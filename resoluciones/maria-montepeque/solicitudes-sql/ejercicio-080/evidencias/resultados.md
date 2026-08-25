# Evidencias - Solicitudes SQL - Ejercicio 080 (Cine Horror Nights)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-080.db < ddl/schema.sql
sqlite3 ejercicio-080.db < dml/inserts.sql
sqlite3 ejercicio-080.db < dml/operaciones.sql
sqlite3 ejercicio-080.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 2 peliculas, 2 salas, 4 funciones
(3 marcadas `finalizada` en algun momento, 1 `programada`), 6 boletos
(incluye el vendido por error en la funcion que se debia cancelar) y
5 pagos.

**Caso comentado verificado** (el problema central del cliente):

- `INSERT INTO boletos (id_funcion, asiento, ...) VALUES (1, 'A1', ...);` (vender de nuevo el asiento A1 de la funcion 1) → `UNIQUE constraint failed: boletos.id_funcion, boletos.asiento`.

**2. Funciones por estado (la funcion 3 ya aparece `cancelada`, se
corrigio con el `UPDATE` de `dml/operaciones.sql`).**

**3. Pelicula con mas boletos vendidos:**

```text
titulo                  boletos_vendidos
La Noche del Espanto      3
Grito Eterno              2
```

**5. Ingresos totales por pelicula (para decidir cual mantener en
cartelera):**

```text
titulo                  ingresos_totales
La Noche del Espanto      135.0
Grito Eterno              100.0
```

## Operaciones de mantenimiento verificadas

- `UPDATE funciones SET estado = 'cancelada' WHERE id_funcion = 3 ...;` → la funcion del 2026-08-02 se anulo despues de confirmarse la falla del proyector.
- **DELETE controlado**: se elimino el unico boleto sin pago de la funcion 3 (asiento A1), apenas se marco `cancelada`. Total de boletos: 6 -> 5. Ningun boleto ya pagado (funciones 1 y 2) se toco.

## Aprendizaje

El `UNIQUE (id_funcion, asiento)` en `boletos` es la restriccion que
resuelve directamente el problema mas clasico de un cine: vender el
mismo asiento dos veces para la misma funcion. El `DELETE` controlado
solo alcanza boletos sin pago; uno ya pagado es un resultado oficial y
nunca se borra, aunque su funcion se cancele. El reporte de ingresos
por pelicula (`GROUP BY` + `HAVING`) confirma que, con un modelo sin
registros repetidos, es facil responder una pregunta real de negocio:
cual pelicula mantener en cartelera.
