# Analisis del requerimiento - Ejercicio 063

## Solicitud entendida

Un estudio de tatuajes agenda sesiones, artistas, estilos y pagos, y
quiere evitar registros incompletos porque despues no puede hacer
reportes confiables. Necesita una base de datos que permita consultar
datos, corregir estados de una sesion, registrar pagos y sacar reportes
utiles, por ejemplo saber que artista tiene mas sesiones completadas o
cuanto se factura por estilo.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Persona que agenda la sesion; se repite en varias sesiones | nombre, telefono (unico) |
| artistas | Tatuador que realiza la sesion; se repite en varias sesiones | nombre, especialidad |
| estilos | Catalogo de estilos de tatuaje; se repite en varias sesiones | nombre (unico) |
| sesiones | Tabla transaccional central: relaciona cliente, artista y estilo en una fecha, con duracion y estado | fecha_sesion, duracion_horas, estado |
| pagos | Movimiento de dinero asociado a una sesion; se separa porque tiene su propio ciclo de vida (pendiente, pagado, reembolsado) y metodo de pago | monto, metodo_pago, estado_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> sesiones | 1:N | Un cliente puede agendar muchas sesiones, cada sesion es de un solo cliente. |
| artistas -> sesiones | 1:N | Un artista puede tener muchas sesiones, cada sesion tiene un solo artista. |
| estilos -> sesiones | 1:N | Un estilo puede aparecer en muchas sesiones, cada sesion es de un solo estilo. |
| sesiones -> pagos | 1:1 | Cada sesion genera un unico registro de pago (`UNIQUE (id_sesion)`). |

## Reglas de negocio

- Regla 1: para evitar registros incompletos, `cliente`, `artista` y
  `estilo` son obligatorios (`NOT NULL`) en toda sesion; no se permite
  crear una sesion "a medias".
- Regla 2: una sesion nace `'agendada'` y solo puede avanzar a
  `'completada'` o `'cancelada'` (`CHECK`).
- Regla 3: la duracion de una sesion debe ser mayor a cero
  (`CHECK (duracion_horas > 0)`).
- Regla 4: cada sesion tiene como maximo un pago
  (`UNIQUE (id_sesion)` en `pagos`), y el monto debe ser mayor a cero.
- Regla 5: el telefono del cliente no se puede repetir (`UNIQUE`), para
  evitar duplicar el mismo cliente con datos distintos.

## Supuestos

- El cliente (dueno del estudio) no especifico si un artista puede
  manejar mas de un estilo; se asume que si, por eso `estilos` es un
  catalogo independiente y no un atributo fijo del artista.
- No se especifico el metodo de pago disponible; se asumen
  `'efectivo'`, `'tarjeta'` y `'transferencia'` como los mas comunes.
- Se asume que una sesion cancelada no genera pago (no aplica el
  `UNIQUE (id_sesion)` en ese caso porque simplemente no se inserta fila
  en `pagos`).

## Preguntas que responde la base de datos

1. Cuales son todas las sesiones con su cliente, artista y estilo.
2. Que sesiones estan agendadas, completadas o canceladas.
3. Que artista tiene mas actividad (ranking por sesiones completadas).
4. Cuales son las sesiones ordenadas por fecha, de la mas reciente a la
   mas antigua.
5. Cuanto se factura por estilo de tatuaje y cuales estilos superan un
   monto minimo (reporte para decision de negocio).
