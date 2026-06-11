import fs from 'node:fs';
import path from 'node:path';

const owner = process.env.GITHUB_REPOSITORY_OWNER;
const repoName = process.env.GITHUB_REPOSITORY?.split('/')[1];
const repoFull = process.env.GITHUB_REPOSITORY;
const eventPath = process.env.GITHUB_EVENT_PATH;
const githubToken = process.env.GITHUB_TOKEN;
const model = process.env.GITHUB_MODELS_REVIEW_MODEL || 'openai/gpt-4.1-mini';
const githubModelsEndpoint = 'https://models.github.ai/inference/chat/completions';
const marker = '<!-- campuslands-ai-feedback -->';

if (!eventPath || !fs.existsSync(eventPath)) {
  throw new Error('No se encontro GITHUB_EVENT_PATH.');
}

const event = JSON.parse(fs.readFileSync(eventPath, 'utf8'));
const pr = event.pull_request;

if (!pr) {
  console.log('No es un evento de Pull Request. Se omite feedback pedagogico.');
  process.exit(0);
}

async function github(pathname, options = {}) {
  const response = await fetch(`https://api.github.com${pathname}`, {
    ...options,
    headers: {
      Authorization: `Bearer ${githubToken}`,
      Accept: 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
      ...(options.headers || {}),
    },
  });
  const text = await response.text();
  const data = text ? JSON.parse(text) : {};
  if (!response.ok) {
    throw new Error(`${response.status} ${response.statusText}: ${data.message || text}`);
  }
  return data;
}

async function listPullFiles() {
  const files = [];
  let page = 1;
  while (true) {
    const batch = await github(`/repos/${repoFull}/pulls/${pr.number}/files?per_page=100&page=${page}`);
    files.push(...batch);
    if (batch.length < 100) break;
    page += 1;
  }
  return files;
}

function readIfExists(filePath, maxChars = 12000) {
  if (!fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) return null;
  const content = fs.readFileSync(filePath, 'utf8');
  return content.length > maxChars
    ? `${content.slice(0, maxChars)}\n\n[contenido truncado para revision automatica]`
    : content;
}

function findNearestReadme(filePath) {
  let current = path.dirname(filePath);
  while (current && current !== '.' && current !== path.dirname(current)) {
    const candidate = path.join(current, 'README.md');
    if (fs.existsSync(candidate)) return candidate;
    current = path.dirname(current);
  }
  return fs.existsSync('README.md') ? 'README.md' : null;
}

function collectReviewContext(files) {
  const technicalFiles = files
    .filter((file) => file.status !== 'removed')
    .map((file) => file.filename)
    .filter((file) => fs.existsSync(file) && fs.statSync(file).isFile())
    .filter((file) => /\.(js|ts|sql|json|md|html|css)$/i.test(file));

  const readmes = [...new Set(technicalFiles.map(findNearestReadme).filter(Boolean))];
  const selectedFiles = technicalFiles.slice(0, 35);

  const instructions = readmes.map((file) => ({
    file,
    content: readIfExists(file, 10000),
  }));

  const submissions = selectedFiles.map((file) => ({
    file,
    content: readIfExists(file, 14000),
  }));

  return {
    repo: repoFull,
    pr: {
      number: pr.number,
      title: pr.title,
      base: pr.base.ref,
      head: pr.head.ref,
      author: pr.user?.login,
    },
    changed_files_count: files.length,
    reviewed_files_count: selectedFiles.length,
    changed_files: files.map((file) => ({
      filename: file.filename,
      status: file.status,
      additions: file.additions,
      deletions: file.deletions,
      patch: file.patch?.slice(0, 6000) || '',
    })),
    exercise_instructions: instructions,
    student_submission: submissions,
  };
}

async function upsertComment(body) {
  const comments = await github(`/repos/${repoFull}/issues/${pr.number}/comments?per_page=100`);
  const previous = comments.find((comment) =>
    comment.user?.type === 'Bot' && comment.body?.includes(marker)
  );

  if (previous) {
    await github(`/repos/${repoFull}/issues/comments/${previous.id}`, {
      method: 'PATCH',
      body: JSON.stringify({ body }),
    });
    return;
  }

  await github(`/repos/${repoFull}/issues/${pr.number}/comments`, {
    method: 'POST',
    body: JSON.stringify({ body }),
  });
}

function extractText(response) {
  return response.choices?.[0]?.message?.content || '';
}

function isFreeLimitOrAccessError(status, message) {
  const normalized = String(message || '').toLowerCase();
  return status === 403 || status === 429 || normalized.includes('rate limit') || normalized.includes('quota') || normalized.includes('limit exceeded') || normalized.includes('no access');
}

function parseJson(text) {
  try {
    return JSON.parse(text);
  } catch {
    const match = text.match(/\{[\s\S]*\}/);
    if (!match) throw new Error('La respuesta IA no contiene JSON valido.');
    return JSON.parse(match[0]);
  }
}

async function requestAiFeedback(context) {
  const prompt = `
Eres un profesor senior de desarrollo en Campuslands. Revisa esta entrega estudiantil con criterio tecnico y pedagogico.

Directrices de revision:
- No apruebes solo porque compila; compara contra el README del ejercicio cuando exista.
- Evalua estructura, claridad, nombres, orden, cumplimiento del objetivo, errores logicos, casos borde y buenas practicas.
- Da feedback directo, accionable y respetuoso en espanol.
- Si falta contexto del enunciado, indicalo como limitacion y revisa lo verificable.
- No inventes requisitos que no esten en el README.
- Si hay problemas que impiden aceptar, decision debe ser "cambios_solicitados".
- Si la solucion es razonable pero hay mejoras menores, decision puede ser "aprobado_con_observaciones".
- Si cumple bien, decision debe ser "aprobado".

Devuelve solo JSON con esta forma:
{
  "decision": "aprobado" | "aprobado_con_observaciones" | "cambios_solicitados",
  "puntaje": 0-100,
  "resumen": "maximo 3 frases",
  "fortalezas": ["..."],
  "problemas": ["..."],
  "sugerencias": ["..."],
  "validacion_recomendada": ["..."],
  "comentario_markdown": "feedback final para publicar en el PR"
}

Contexto del PR:
${JSON.stringify(context, null, 2)}
`;

  const response = await fetch(githubModelsEndpoint, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${githubToken}`,
      'Content-Type': 'application/json',
      'X-GitHub-Api-Version': '2022-11-28',
    },
    body: JSON.stringify({
      model,
      messages: [
        { role: 'system', content: 'Eres un revisor pedagogico estricto y util para una academia tecnica. Responde solo JSON valido.' },
        { role: 'user', content: prompt },
      ],
      temperature: 0.2,
      max_tokens: 1800,
    }),
  });

  const text = await response.text();
  let data;
  try {
    data = text ? JSON.parse(text) : {};
  } catch {
    throw new Error(`GitHub Models devolvio una respuesta no JSON: ${text.slice(0, 500)}`);
  }

  if (!response.ok) {
    const message = data.error?.message || data.message || text;
    if (isFreeLimitOrAccessError(response.status, message)) {
      return {
        skipped: true,
        reason: message,
      };
    }
    throw new Error(`GitHub Models error: ${message}`);
  }

  return parseJson(extractText(data));
}

const files = await listPullFiles();
const context = collectReviewContext(files);

const feedback = await requestAiFeedback(context);

if (feedback.skipped) {
  await upsertComment([
    marker,
    '## Feedback pedagogico automatico pausado',
    '',
    'GitHub Models no pudo generar la revision IA en este momento usando el cupo gratuito.',
    '',
    'Motivo reportado por GitHub:',
    `> ${String(feedback.reason || 'limite gratuito agotado o modelo no disponible').slice(0, 1000)}`,
    '',
    'Los checks de estructura y codigo siguen activos. Este PR queda pendiente de revision pedagogica cuando vuelva a haber cupo gratuito o cuando el alumno haga nuevos cambios.',
  ].join('\n'));
  console.log('GitHub Models sin cupo/acceso gratuito disponible. Se omite feedback IA.');
  process.exit(0);
}

const decision = String(feedback.decision || '').toLowerCase();
const score = Number(feedback.puntaje || 0);
const body = [
  marker,
  '## Feedback pedagogico automatico',
  '',
  `Decision: **${feedback.decision || 'sin decision'}**`,
  `Puntaje orientativo: **${Number.isFinite(score) ? score : 0}/100**`,
  '',
  feedback.comentario_markdown || feedback.resumen || 'Sin comentario generado.',
  '',
  '<sub>Revision generada automaticamente. El profesor puede ajustar el criterio final si el ejercicio lo requiere.</sub>',
].join('\n');

await upsertComment(body);

if (decision === 'cambios_solicitados' || score < 70) {
  throw new Error(`Feedback pedagogico solicita cambios. Puntaje: ${score}/100`);
}

console.log(`Feedback pedagogico aprobado con decision=${decision} puntaje=${score}`);
