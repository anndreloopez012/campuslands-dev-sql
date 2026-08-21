# Diagrama ER

## Modelo

El modelo representa un servicio de delivery que administra clientes, restaurantes, repartidores y pedidos. La entidad `pedidos` concentra la operación principal y relaciona al cliente, restaurante y repartidor involucrados.

```mermaid
erDiagram
    CLIENTES ||--o{ PEDIDOS : realiza
    RESTAURANTES ||--o{ PEDIDOS : recibe
    REPARTIDORES ||--o{ PEDIDOS : entrega

    CLIENTES {
        INTEGER id_cliente PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT telefono
        TEXT direccion
    }

    RESTAURANTES {
        INTEGER id_restaurante PK
        TEXT nombre
        TEXT telefono UK
        TEXT categoria
        REAL calificacion
    }

    REPARTIDORES {
        INTEGER id_repartidor PK
        TEXT nombre_completo
        TEXT telefono UK
        TEXT vehiculo
        INTEGER disponible
    }

    PEDIDOS {
        INTEGER id_pedido PK
        INTEGER id_cliente FK
        INTEGER id_restaurante FK
        INTEGER id_repartidor FK
        TEXT fecha_pedido
        TEXT estado
        REAL total
        INTEGER tiempo_estimado_min
    }
```

## Relaciones

- `clientes` almacena los usuarios que realizan pedidos.
- `restaurantes` almacena los establecimientos que reciben los pedidos.
- `repartidores` registra las personas encargadas de entregar los pedidos.
- `pedidos` representa la entidad transaccional central.
- Un cliente puede realizar múltiples pedidos.
- Un restaurante puede recibir múltiples pedidos.
- Un repartidor puede entregar múltiples pedidos.

## Restricciones relevantes

- Todas las tablas poseen `PRIMARY KEY`.
- `pedidos` utiliza tres `FOREIGN KEY`.
- Los campos obligatorios utilizan `NOT NULL`.
- Los correos y teléfonos utilizan `UNIQUE` donde corresponde.
- La calificación de los restaurantes debe estar entre 1 y 5.
- El tipo de vehículo de los repartidores está limitado a `MOTO`, `BICICLETA` o `AUTOMOVIL`.
- La disponibilidad de los repartidores solo admite `0` o `1`.
- Los estados de los pedidos están restringidos a valores válidos.
- El total y el tiempo estimado deben ser mayores que cero.
- Las claves foráneas están activadas mediante `PRAGMA foreign_keys = ON`.