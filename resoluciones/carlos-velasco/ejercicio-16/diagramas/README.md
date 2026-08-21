## Modelo

El modelo está compuesto por cuatro entidades:

- `aeropuertos`: almacena los aeropuertos disponibles para las operaciones de origen y destino.
- `aviones`: almacena las aeronaves, su capacidad y estado operativo.
- `vuelos`: representa los vuelos programados y relaciona un avión con dos aeropuertos.
- `reservas`: registra los pasajeros asociados a cada vuelo.

## Relaciones

- Un aeropuerto puede ser origen de muchos vuelos.
- Un aeropuerto puede ser destino de muchos vuelos.
- Un avión puede realizar muchos vuelos.
- Un vuelo puede tener muchas reservas.
- Cada reserva pertenece a un único vuelo.

```mermaid
erDiagram
    AEROPUERTOS ||--o{ VUELOS : "es origen"
    AEROPUERTOS ||--o{ VUELOS : "es destino"
    AVIONES ||--o{ VUELOS : realiza
    VUELOS ||--o{ RESERVAS : recibe

    AEROPUERTOS {
        INTEGER id_aeropuerto PK
        TEXT codigo_iata UK
        TEXT nombre
        TEXT ciudad
        TEXT pais
    }

    AVIONES {
        INTEGER id_avion PK
        TEXT matricula UK
        TEXT modelo
        INTEGER capacidad
        TEXT estado
    }

    VUELOS {
        INTEGER id_vuelo PK
        TEXT codigo_vuelo UK
        INTEGER aeropuerto_origen_id FK
        INTEGER aeropuerto_destino_id FK
        INTEGER avion_id FK
        TEXT fecha_salida
        TEXT fecha_llegada
        TEXT estado
    }

    RESERVAS {
        INTEGER id_reserva PK
        INTEGER vuelo_id FK
        TEXT nombre_pasajero
        TEXT documento UK
        TEXT asiento
        TEXT fecha_reserva
        TEXT estado
    }
```

## Restricciones representadas

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` entre vuelos y aeropuertos, vuelos y aviones, y reservas y vuelos.
- `UNIQUE` para códigos IATA, matrículas, códigos de vuelo y documentos.
- `CHECK` para capacidad, estados, origen/destino y orden cronológico de las fechas.
- `UNIQUE (vuelo_id, asiento)` para impedir que un mismo asiento sea reservado dos veces en un vuelo.