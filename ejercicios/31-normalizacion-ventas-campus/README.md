# Ejercicio 31: Normalizacion Ventas Campus

## Objetivo

Practicar normalizacion de datos desde una tabla sin normalizar hasta un modelo relacional implementado en SQLite.

El estudiante debe identificar datos repetidos, dependencias funcionales, grupos repetidos y anomalias de insercion, actualizacion y eliminacion.

## Contexto

La empresa tiene un archivo plano para administrar ventas con clientes y productos repetidos. La informacion se captura en una sola tabla con columnas como:

```text
cliente_nombre, cliente_email, productos_comprados, precios, cantidades, vendedor, sucursal
```

Este diseno genera problemas:

- Datos duplicados.
- Dificultad para actualizar informacion sin inconsistencias.
- Eliminaciones que pueden borrar informacion importante.
- Campos con multiples valores en una misma celda.
- Reportes lentos o dificiles de escribir.

## Tabla sin normalizar

Revise el archivo:

```text
plantilla/datos/datos-sin-normalizar.csv
```

Ese archivo representa el punto de partida. No lo trate como solucion final.

## Actividades

1. Identifique la clave candidata de la tabla original.
2. Liste las dependencias funcionales encontradas.
3. Explique que columnas violan la Primera Forma Normal.
4. Transforme el diseno a Primera Forma Normal (1FN).
5. Transforme el diseno a Segunda Forma Normal (2FN).
6. Transforme el diseno a Tercera Forma Normal (3FN).
7. Dibuje el diagrama E-R del modelo final.
8. Implemente el modelo final en SQLite.
9. Inserte datos equivalentes al archivo original, pero ya normalizados.
10. Cree consultas para demostrar que el modelo funciona.

## Resultado esperado

Separar clientes, productos, vendedores, ventas y detalle_venta.

## Entregables

Su solucion debe quedar en:

```text
resoluciones/apellido-nombre/ejercicio-31/
├── README.md
├── analisis/
│   └── normalizacion.md
├── diagramas/
│   └── diagrama-er.png
├── ddl/
│   └── schema.sql
├── dml/
│   └── inserts.sql
└── dql/
    └── consultas.sql
```

## Requisitos del analisis

En `analisis/normalizacion.md` documente:

- Tabla original sin normalizar.
- Problemas detectados.
- Dependencias funcionales.
- Proceso a 1FN.
- Proceso a 2FN.
- Proceso a 3FN.
- Justificacion de cada tabla final.

## Requisitos del DDL

En `ddl/schema.sql` incluya:

- `PRAGMA foreign_keys = ON;`
- Llaves primarias.
- Llaves foraneas.
- Campos `NOT NULL`.
- Minimo una restriccion `UNIQUE`.
- Minimo dos restricciones `CHECK`.

## Requisitos del DML

En `dml/inserts.sql` incluya datos normalizados equivalentes al CSV original y agregue registros adicionales para probar el modelo.

Debe incluir minimo:

- 5 registros en tablas catalogo.
- 10 registros en tablas transaccionales o detalle.
- 2 casos comentados que deben fallar por restricciones.

## Consultas obligatorias

En `dql/consultas.sql` escriba consultas para:

1. Reconstruir una vista similar al archivo original usando `JOIN`.
2. Listar entidades principales sin duplicados.
3. Contar registros por categoria o estado.
4. Calcular un total por transaccion.
5. Calcular promedio, minimo o maximo.
6. Buscar registros por texto con `LIKE`.
7. Filtrar por fecha o rango numerico.
8. Mostrar top 5 por cantidad o monto.
9. Detectar registros relacionados sin detalle, si aplica.
10. Crear un reporte final con alias legibles.

## Como ejecutar

Desde la raiz de su solucion:

```bash
sqlite3 ejercicio-31.db < ddl/schema.sql
sqlite3 ejercicio-31.db < dml/inserts.sql
sqlite3 ejercicio-31.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-31
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/31-normalizacion-ventas-campus/plantilla resoluciones/apellido-nombre/ejercicio-31
```

Despues de resolver:

```bash
git add resoluciones/apellido-nombre/ejercicio-31
git commit -m "feat(sql): resolver normalizacion ejercicio 31"
git push -u origin alumno/apellido-nombre/ejercicio-31
```

Abra Pull Request hacia `dev`. No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Identificacion de problemas y dependencias | 25% |
| Normalizacion 1FN, 2FN y 3FN | 30% |
| Modelo SQLite con restricciones | 20% |
| Datos y consultas de validacion | 15% |
| Documentacion y evidencias | 10% |
