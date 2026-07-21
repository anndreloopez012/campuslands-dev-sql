# Ejercicio 89: GROUP BY Nivel Basico

## Tema central

`GROUP BY`

## Objetivo

Agrupar datos y calcular totales, conteos y promedios.

Este ejercicio es de nivel basico. Debe resolver un caso pequeno con una tabla principal y validaciones directas.


## Contexto

Trabajara sobre un sistema de agenda de citas. El negocio necesita administrar citas programadas por fecha y practicar especificamente `GROUP BY` sin dejar de usar las bases normales de SQL.

## Entidades sugeridas

- `pacientes`
- `medicos`
- `citas`

Puede ajustar nombres si mantiene la coherencia del modelo.

## Actividades

1. Lea el contexto y defina el modelo minimo necesario.
2. Cree el archivo `ddl/schema.sql` con las tablas u objetos necesarios.
3. Agregue datos de prueba en `dml/inserts.sql`.
4. Escriba consultas de validacion en `dql/consultas.sql`.
5. Documente en `README.md` de su solucion que aprendio del tema `GROUP BY`.

## Requisitos especificos

- El ejercicio debe demostrar claramente el uso de `GROUP BY`.
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
5. Una consulta que demuestre que `GROUP BY` cumple su proposito.

## Entregables

```text
resoluciones/apellido-nombre/ejercicio-89/
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
sqlite3 ejercicio-89.db < ddl/schema.sql
sqlite3 ejercicio-89.db < dml/inserts.sql
sqlite3 ejercicio-89.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-89
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/89-group-by-basico/plantilla resoluciones/apellido-nombre/ejercicio-89
```

Despues de resolver:

```bash
git add resoluciones/apellido-nombre/ejercicio-89
git commit -m "feat(sql): resolver ejercicio 89"
git push -u origin alumno/apellido-nombre/ejercicio-89
```

Abra Pull Request hacia `dev`. No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Uso correcto de `GROUP BY` | 35% |
| Modelo y restricciones base | 25% |
| Datos de prueba | 15% |
| Consultas de validacion | 15% |
| Documentacion y evidencias | 10% |
