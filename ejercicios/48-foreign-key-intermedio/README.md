# Ejercicio 48: FOREIGN KEY Nivel Intermedio

## Tema central

`FOREIGN KEY`

## Objetivo

Relacionar tablas y proteger integridad referencial con llaves foraneas.

Este ejercicio es de nivel intermedio. Debe resolver un caso con dos o tres tablas y relaciones simples.


## Contexto

Trabajara sobre un sistema de biblioteca tecnica. El negocio necesita administrar prestamos de libros tecnicos y practicar especificamente `FOREIGN KEY` sin dejar de usar las bases normales de SQL.

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
5. Documente en `README.md` de su solucion que aprendio del tema `FOREIGN KEY`.

## Requisitos especificos

- El ejercicio debe demostrar claramente el uso de `FOREIGN KEY`.
- Agregue comentarios SQL que expliquen donde se aplica el tema.
- Incluya al menos un caso valido y un caso comentado que deberia fallar o no ser recomendable.
- Use nombres de tablas y columnas claros.
- Mantenga los scripts ejecutables en SQLite salvo que el README indique una excepcion conceptual.

## Consultas minimas

En `dql/consultas.sql` incluya:

1. Una consulta que muestre todos los datos principales.
2. Una consulta filtrada con `WHERE`.
3. Una consulta ordenada con `ORDER BY`.
4. Una consulta de conteo o resumen.
5. Una consulta que demuestre que `FOREIGN KEY` cumple su proposito.

## Entregables

```text
resoluciones/apellido-nombre/ejercicio-48/
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
sqlite3 ejercicio-48.db < ddl/schema.sql
sqlite3 ejercicio-48.db < dml/inserts.sql
sqlite3 ejercicio-48.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-48
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/48-foreign-key-intermedio/plantilla resoluciones/apellido-nombre/ejercicio-48
```

Despues de resolver:

```bash
git add resoluciones/apellido-nombre/ejercicio-48
git commit -m "feat(sql): resolver ejercicio 48"
git push -u origin alumno/apellido-nombre/ejercicio-48
```

Abra Pull Request hacia `dev`. No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Uso correcto de `FOREIGN KEY` | 35% |
| Modelo y restricciones base | 25% |
| Datos de prueba | 15% |
| Consultas de validacion | 15% |
| Documentacion y evidencias | 10% |
