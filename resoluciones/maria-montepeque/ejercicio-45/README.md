# Ejercicio 45: PRIMARY KEY Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

PRIMARY KEY

## Descripcion del problema

Sistema de ventas diarias de una cafeteria: `productos`, `clientes` y `ventas`. Nivel intermedio: profundiza el tema de PRIMARY KEY del ejercicio 44 contrastando dos estrategias distintas para elegir la llave primaria en la misma base de datos.

## Tablas y relaciones

- `productos`: catalogo del menu, con **PRIMARY KEY natural** (`codigo_barras`).
- `clientes`: catalogo de clientes, con **PRIMARY KEY subrogada** (`id_cliente` autoincremental).
- `ventas`: cada venta, referenciando a `clientes` y `productos` por sus respectivas PRIMARY KEY.

## Que aprendi sobre PRIMARY KEY

- **PRIMARY KEY natural vs. subrogada, en la misma base de datos**: en `productos` se uso `codigo_barras` directamente como `PRIMARY KEY` porque es un dato que ya es unico por naturaleza del negocio, no cambia con el tiempo y es literalmente lo que se lee al vender. En `clientes`, en cambio, no hay un dato tan estable (el correo puede faltar o cambiar), asi que se prefirio una llave subrogada (`id_cliente` autoincremental). No hay una regla unica: la decision depende de si el dato natural es realmente estable y siempre esta disponible.
- **La PRIMARY KEY solo exige unicidad en su propia tabla**: `codigo_barras` es `PRIMARY KEY` en `productos` (no puede repetirse ahi), pero en `ventas` es solo una `FOREIGN KEY`, y ahi si se repite libremente cada vez que se vende ese producto (lo verifique en la consulta 5.a, donde `750100001` aparece en 4 ventas distintas). Confundir "llave primaria" con "valor que nunca se repite en todo el sistema" es un error comun que este ejercicio ayuda a evitar.
- **La PRIMARY KEY habilita las relaciones**: solo se puede crear una `FOREIGN KEY` hacia una columna que sea `PRIMARY KEY` (o `UNIQUE`) en la tabla de destino. Por eso `ventas.id_cliente` y `ventas.codigo_barras` apuntan exactamente a las columnas que son `PRIMARY KEY` en `clientes` y `productos`.
- Los dos casos comentados muestran que, sin importar si la `PRIMARY KEY` es natural o subrogada, intentar duplicarla siempre falla con el mismo tipo de error (`UNIQUE constraint failed` sobre la columna de la llave).

## Como ejecutar

```bash
sqlite3 ejercicio-45.db < ddl/schema.sql
sqlite3 ejercicio-45.db < dml/inserts.sql
sqlite3 ejercicio-45.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
