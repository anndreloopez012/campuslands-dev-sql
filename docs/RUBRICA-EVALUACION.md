# Rubrica de evaluacion

Esta rubrica ayuda a que todos los maestros califiquen con el mismo criterio. Puede usarse para revisar ejercicios individuales, bloques semanales o entregas de proyecto.

## Escala sugerida

| Nivel | Descripcion |
|---|---|
| 4 | Excelente: cumple y supera lo esperado. |
| 3 | Correcto: cumple lo solicitado con detalles menores. |
| 2 | Parcial: tiene avances, pero requiere correcciones importantes. |
| 1 | Insuficiente: no cumple el objetivo minimo. |
| 0 | No entregado, fuera de estructura o imposible de revisar. |

## Criterios generales

| Criterio | Peso sugerido | Que se evalua |
|---|---:|---|
| Estructura | 20% | Ubicacion correcta, carpetas, nombres, no tocar archivos base. |
| Logica | 30% | Solucion del problema, analisis, reglas, calculos y casos borde. |
| Claridad | 15% | Codigo o respuesta facil de leer, nombres claros, separacion de ideas. |
| Pruebas | 15% | Evidencia de ejecucion, casos normales, limites e invalidos. |
| Git | 10% | Rama correcta, commits claros, PR hacia `dev`, sin archivos innecesarios. |
| Orden | 10% | Limpieza general, no mezclar ejercicios, no subir basura o duplicados. |

## Rubrica por criterio

### 1. Estructura

- 4: Todo esta en `resoluciones/nombre-apellido/`, con nombres correctos y sin modificar base.
- 3: Estructura correcta con detalles menores de nombre u organizacion.
- 2: La entrega esta parcialmente ubicada, pero mezcla archivos o rutas confusas.
- 1: La entrega esta fuera de lugar o toca archivos que no debe.
- 0: No se puede revisar por estructura incorrecta grave.

### 2. Logica

- 4: Resuelve el problema completo, contempla casos borde y demuestra analisis.
- 3: Resuelve el objetivo principal con pequenos detalles pendientes.
- 2: Resuelve una parte, pero falla en reglas importantes.
- 1: La solucion es superficial o no corresponde bien al enunciado.
- 0: No hay solucion funcional o no corresponde al ejercicio.

### 3. Claridad

- 4: Se entiende facilmente, usa nombres descriptivos y separa responsabilidades.
- 3: Es legible, aunque puede mejorar nombres, comentarios o separacion.
- 2: Se entiende con esfuerzo; hay duplicacion o desorden.
- 1: Es dificil de seguir y no comunica bien la intencion.
- 0: No hay claridad suficiente para revisar.

### 4. Pruebas

- 4: Incluye o demuestra pruebas con caso normal, limite e invalido.
- 3: Prueba el caso principal y al menos un caso adicional.
- 2: Solo prueba el caso feliz.
- 1: No queda claro si probo la solucion.
- 0: No ejecuta o no hay evidencia revisable.

### 5. Git

- 4: Rama personal, commits claros, PR hacia `dev` y descripcion util.
- 3: Flujo Git correcto con detalles menores en commits o descripcion.
- 2: PR correcto, pero commits confusos o mezcla de cambios.
- 1: Rama o PR mal planteado; requiere guia del maestro.
- 0: Push/PR hacia rama incorrecta o cambios imposibles de integrar.

### 6. Orden

- 4: Entrega limpia, enfocada, sin archivos innecesarios ni duplicados.
- 3: Orden general correcto con pequenos residuos.
- 2: Hay archivos de mas o mezcla de ejercicios, pero se puede revisar.
- 1: Mucho ruido, duplicados o estructura dificil de auditar.
- 0: El desorden impide evaluar.

## Interpretacion por nivel del curso

### Basico

En basico se prioriza que el estudiante entienda el problema, escriba una solucion propia y respete la estructura. No se debe castigar con dureza si aun no abstrae perfecto, pero si debe explicar su idea.

### Intermedio

En intermedio se espera mejor separacion, funciones reutilizables, validaciones y pruebas mas claras. La estructura ya no debe fallar.

### Avanzado

En avanzado se espera pensar en mantenibilidad, seguridad, errores, datos y contratos. El estudiante debe justificar decisiones tecnicas.

### Experto

En experto se evalua criterio profesional: arquitectura, consistencia, trazabilidad, manejo de errores, rendimiento razonable y claridad para que otro dev mantenga el trabajo.

## Resultado recomendado

| Promedio | Decision sugerida |
|---:|---|
| 3.5 a 4.0 | Aprobar y mergear. |
| 2.8 a 3.4 | Aprobar si no hay riesgos; dejar recomendaciones. |
| 2.0 a 2.7 | Solicitar cambios antes de mergear. |
| 1.0 a 1.9 | Rechazar o pedir rehacer. |
| 0 a 0.9 | No aceptado por incumplimiento grave o falta de entrega. |

## Comentario final sugerido

```markdown
## Evaluacion

Estructura: 4/4
Logica: 3/4
Claridad: 3/4
Pruebas: 2/4
Git: 4/4
Orden: 4/4

Decision: aprobado con recomendaciones.

Feedback:
- La solucion cumple el objetivo principal.
- Agrega mas casos de prueba en la siguiente entrega.
```
