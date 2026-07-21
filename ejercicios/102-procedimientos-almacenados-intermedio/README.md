# Ejercicio 102: Procedimientos almacenados Nivel Intermedio

## Tema central

`Procedimientos almacenados`

## Objetivo

Comprender procedimientos almacenados de forma conceptual y escribir equivalentes documentados para motores que los soportan.

Este ejercicio es de nivel intermedio. Debe resolver un caso con dos o tres tablas y relaciones simples.


> Nota: SQLite no soporta procedimientos almacenados nativos. Para este ejercicio documente el procedimiento en SQL teorico para MySQL o PostgreSQL y agregue una alternativa ejecutable en SQLite usando scripts, vistas o triggers cuando aplique.


## Contexto

Trabajara sobre un sistema de biblioteca tecnica. El negocio necesita administrar prestamos de libros tecnicos y practicar especificamente `Procedimientos almacenados` sin dejar de usar las bases normales de SQL.

## Entidades sugeridas

- `libros`
- `autores`
- `prestamos`

Puede ajustar nombres si mantiene la coherencia del modelo.

## Actividades

1. Lea el contexto y defina el modelo minimo necesario.
2. Cree el archivo `ddl/schema.sql` con las tablas u objetos necesarios.
3. Agregue datos de prueba en `dml/inserts.sql`.
4. Escriba consultas de validacion en `dql/consultas.sql`.
5. Documente en `README.md` de su solucion que aprendio del tema `Procedimientos almacenados`.

## Requisitos especificos

- El ejercicio debe demostrar claramente el uso de `Procedimientos almacenados`.
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
5. Una consulta que demuestre que `Procedimientos almacenados` cumple su proposito.

## Entregables

```text
resoluciones/apellido-nombre/ejercicio-102/
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
sqlite3 ejercicio-102.db < ddl/schema.sql
sqlite3 ejercicio-102.db < dml/inserts.sql
sqlite3 ejercicio-102.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-102
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/102-procedimientos-almacenados-intermedio/plantilla resoluciones/apellido-nombre/ejercicio-102
```

Despues de resolver:

```bash
git add resoluciones/apellido-nombre/ejercicio-102
git commit -m "feat(sql): resolver ejercicio 102"
git push -u origin alumno/apellido-nombre/ejercicio-102
```

Abra Pull Request hacia `dev`. No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Uso correcto de `Procedimientos almacenados` | 35% |
| Modelo y restricciones base | 25% |
| Datos de prueba | 15% |
| Consultas de validacion | 15% |
| Documentacion y evidencias | 10% |
