# Diagrama ER

## Modelo entidad-relacion

El modelo está compuesto por cuatro entidades: `rutas`, `buses`, `conductores` y `viajes`.

La tabla `viajes` funciona como entidad central y relaciona rutas, buses y conductores para representar cada viaje programado.

```mermaid
erDiagram
    RUTAS ||--o{ VIAJES : "programa"
    BUSES ||--o{ VIAJES : "asigna"
    CONDUCTORES ||--o{ VIAJES : "conduce"

    RUTAS {
        INTEGER id_ruta PK
        TEXT codigo UK
        TEXT origen
        TEXT destino
        REAL distancia_km
    }

    BUSES {
        INTEGER id_bus PK
        TEXT placa UK
        TEXT modelo
        INTEGER capacidad
        INTEGER anio
        TEXT estado
    }

    CONDUCTORES {
        INTEGER id_conductor PK
        TEXT nombre_completo
        TEXT documento UK
        TEXT licencia UK
        TEXT telefono
        TEXT estado
    }

    VIAJES {
        INTEGER id_viaje PK
        INTEGER id_ruta FK
        INTEGER id_bus FK
        INTEGER id_conductor FK
        TEXT fecha_hora
        INTEGER pasajeros_registrados
        TEXT estado
    }
```

## Relaciones

- `rutas` 1:N `viajes`: una ruta puede tener múltiples viajes programados y cada viaje pertenece a una ruta.
- `buses` 1:N `viajes`: un bus puede participar en múltiples viajes en diferentes horarios y cada viaje utiliza un bus.
- `conductores` 1:N `viajes`: un conductor puede realizar múltiples viajes en diferentes horarios y cada viaje tiene un conductor.
- `rutas` utiliza `codigo` como identificador único.
- `buses` utiliza `placa` como identificador único.
- `conductores` utiliza `documento` y `licencia` como valores únicos.
- `viajes` utiliza `UNIQUE (id_bus, fecha_hora)` para impedir asignar el mismo bus a dos viajes simultáneos.
- `viajes` utiliza `UNIQUE (id_conductor, fecha_hora)` para impedir asignar el mismo conductor a dos viajes simultáneos.