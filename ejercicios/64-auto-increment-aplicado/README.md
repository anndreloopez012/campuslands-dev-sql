# Ejercicio 64: AUTO_INCREMENT Nivel Aplicado

## Tema central

`AUTO_INCREMENT`

## Objetivo

Usar INTEGER PRIMARY KEY AUTOINCREMENT en SQLite para ids generados automaticamente.

Este ejercicio es de nivel aplicado. Debe resolver un caso de negocio con reporte o validacion final.


> En SQLite el equivalente practico se trabaja con `INTEGER PRIMARY KEY AUTOINCREMENT`.


## Contexto

Trabajara sobre un sistema de biblioteca tecnica. El negocio necesita administrar prestamos de libros tecnicos y practicar especificamente `AUTO_INCREMENT` sin dejar de usar las bases normales de SQL.

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
5. Documente en `README.md` de su solucion que aprendio del tema `AUTO_INCREMENT`.

## Requisitos especificos

- El ejercicio debe demostrar claramente el uso de `AUTO_INCREMENT`.
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
5. Una consulta que demuestre que `AUTO_INCREMENT` cumple su proposito.

## Entregables

```text
resoluciones/apellido-nombre/ejercicio-64/
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
sqlite3 ejercicio-64.db < ddl/schema.sql
sqlite3 ejercicio-64.db < dml/inserts.sql
sqlite3 ejercicio-64.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-64
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/64-auto-increment-aplicado/plantilla resoluciones/apellido-nombre/ejercicio-64
```

Despues de resolver:

```bash
git add resoluciones/apellido-nombre/ejercicio-64
git commit -m "feat(sql): resolver ejercicio 64"
git push -u origin alumno/apellido-nombre/ejercicio-64
```

Abra Pull Request hacia `dev`. No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Uso correcto de `AUTO_INCREMENT` | 35% |
| Modelo y restricciones base | 25% |
| Datos de prueba | 15% |
| Consultas de validacion | 15% |
| Documentacion y evidencias | 10% |
