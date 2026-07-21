# Ejercicio 42: Tipos de datos Nivel Intermedio

## Tema central

`Tipos de datos`

## Objetivo

Elegir y justificar tipos como INTEGER, REAL, TEXT, DATE simulado y BOOLEAN simulado en SQLite.

Este ejercicio es de nivel intermedio. Debe resolver un caso con dos o tres tablas y relaciones simples.


## Contexto

Trabajara sobre un sistema de registro de campers. El negocio necesita administrar campers inscritos en rutas de entrenamiento y practicar especificamente `Tipos de datos` sin dejar de usar las bases normales de SQL.

## Entidades sugeridas

- `campers`
- `rutas`
- `inscripciones`

Puede ajustar nombres si mantiene la coherencia del modelo.

## Actividades

1. Lea el contexto y defina el modelo minimo necesario.
2. Cree el archivo `ddl/schema.sql` con las tablas u objetos necesarios.
3. Agregue datos de prueba en `dml/inserts.sql`.
4. Escriba consultas de validacion en `dql/consultas.sql`.
5. Documente en `README.md` de su solucion que aprendio del tema `Tipos de datos`.

## Requisitos especificos

- El ejercicio debe demostrar claramente el uso de `Tipos de datos`.
- Agregue comentarios SQL que expliquen donde se aplica el tema.
- Incluya al menos un caso valido y un caso comentado que deberia fallar o no ser recomendable.
- Use nombres de tablas y columnas claros.
- Mantenga los scripts ejecutables en SQLite salvo que el README indique una excepcion conceptual.
- Use tambien `PRIMARY KEY`, `NOT NULL`, `CHECK` y `DEFAULT` cuando complementen el ejercicio.

## Consultas minimas

En `dql/consultas.sql` incluya:

1. Una consulta que muestre todos los datos principales.
2. Una consulta filtrada con `WHERE`.
3. Una consulta ordenada con `ORDER BY`.
4. Una consulta de conteo o resumen.
5. Una consulta que demuestre que `Tipos de datos` cumple su proposito.

## Entregables

```text
resoluciones/apellido-nombre/ejercicio-42/
├── README.md
├── ddl/
│   └── schema.sql
├── dml/
│   └── inserts.sql
├── dql/
│   └── consultas.sql
└── evidencias/
    └── resultados.md
```

## Como ejecutar

```bash
sqlite3 ejercicio-42.db < ddl/schema.sql
sqlite3 ejercicio-42.db < dml/inserts.sql
sqlite3 ejercicio-42.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-42
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/42-tipos-datos-intermedio/plantilla resoluciones/apellido-nombre/ejercicio-42
```

Despues de resolver:

```bash
git add resoluciones/apellido-nombre/ejercicio-42
git commit -m "feat(sql): resolver ejercicio 42"
git push -u origin alumno/apellido-nombre/ejercicio-42
```

Abra Pull Request hacia `dev`. No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Uso correcto de `Tipos de datos` | 35% |
| Modelo y restricciones base | 25% |
| Datos de prueba | 15% |
| Consultas de validacion | 15% |
| Documentacion y evidencias | 10% |
