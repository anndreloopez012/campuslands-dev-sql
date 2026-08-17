# Ejercicio 066: Solicitud de cliente - Hotel Gamers

## Dificultad

Nivel 4 - reportes y agrupaciones

## Tema

Comprension de una solicitud escrita por un cliente y transformacion a modelo relacional SQL.

## Contexto del cliente

Un hotel tematico recibe reservas, habitaciones, torneos internos y consumos.

Solicitud recibida:

> El cliente quiere diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos.
> Necesito que me ayuden a convertir esta operacion en una base de datos. No quiero solo guardar texto; quiero poder consultar datos, corregir estados, registrar movimientos y sacar reportes utiles.

## Objetivo

Leer la solicitud como analista, separar la informacion importante y convertirla en:

- Tablas relacionales.
- Relaciones con llaves primarias y foraneas.
- Datos de prueba con `INSERT`.
- Cambios controlados con `UPDATE`.
- Eliminaciones seguras con `DELETE` cuando aplique.
- Consultas que respondan preguntas reales del cliente.

## Alcance tecnico

4 a 5 tablas, consultas con JOIN, GROUP BY, HAVING, totales y ranking.

Habilidades principales:

- crear reportes
- agrupar datos
- filtrar agregados
- ordenar resultados

## Entidades sugeridas

Puede iniciar con estas entidades, pero debe ajustar atributos y relaciones segun su analisis:

- `huespedes`
- `habitaciones`
- `reservas`
- `consumos`
- `eventos`

## Como pensar el problema

1. Subraye los sustantivos importantes de la solicitud. Normalmente se convierten en tablas o atributos.
2. Marque las acciones del negocio. Normalmente se convierten en tablas transaccionales o relaciones.
3. Pregunte que dato no puede faltar. Eso le ayuda a definir `NOT NULL`.
4. Identifique datos repetidos. Eso le ayuda a separar catalogos.
5. Busque reglas del negocio. Eso le ayuda a usar `CHECK`, `UNIQUE`, `FOREIGN KEY` y valores por defecto.
6. Antes de escribir SQL, explique su modelo en palabras simples.

## Requerimientos obligatorios

En su solucion debe incluir:

- Minimo `5` tablas coherentes con el caso.
- `PRIMARY KEY` en cada tabla.
- `FOREIGN KEY` cuando una tabla dependa de otra.
- `NOT NULL` en campos realmente obligatorios.
- Al menos una restriccion `CHECK` o `UNIQUE`.
- Datos de prueba suficientes para demostrar que el modelo funciona.
- Comentarios SQL que expliquen decisiones importantes.

Operaciones requeridas para este ejercicio:

- SELECT simples
- INSERT de datos base
- JOIN entre tablas
- UPDATE de estado
- DELETE controlado
- validaciones con CHECK o UNIQUE
- GROUP BY
- HAVING
- ranking o resumen ejecutivo

## Archivos que debe completar

Copie la plantilla y complete:

```text
resoluciones/nombre-apellido/solicitudes-sql/ejercicio-066/
├── README.md
├── analisis/
│   └── requerimiento.md
├── diagramas/
│   └── diagrama-er.png
├── ddl/
│   └── schema.sql
├── dml/
│   ├── inserts.sql
│   └── operaciones.sql
├── dql/
│   └── consultas.sql
└── evidencias/
    └── resultados.md
```

## Instrucciones detalladas

1. Lea la solicitud completa antes de crear tablas.
2. Complete `analisis/requerimiento.md` con entidades, atributos, relaciones y supuestos.
3. Cree el modelo en `ddl/schema.sql`.
4. Inserte datos base en `dml/inserts.sql`.
5. Agregue operaciones de mantenimiento en `dml/operaciones.sql`.
6. Responda las preguntas del cliente en `dql/consultas.sql`.
7. Documente resultados en `evidencias/resultados.md`.
8. Verifique que los scripts puedan ejecutarse en orden.

## Consultas minimas esperadas

Debe crear consultas para responder:

1. Que registros principales existen.
2. Que registros estan activos, pendientes o finalizados.
3. Que cliente, usuario, jugador, producto o entidad central tiene mas actividad.
4. Cuales son los datos ordenados por fecha, prioridad o valor.
5. Que reporte podria usar el cliente para tomar una decision.

## Ejemplo de razonamiento

Si el cliente dice: "quiero saber que cliente compro y cuanto pago", no basta con una tabla `ventas` llena de texto. Una solucion mas profesional separa `clientes`, `ventas` y posiblemente `detalle_ventas` o `pagos`.

## Entregable esperado

Una carpeta de solucion completa, ejecutable y documentada. El profesor debe poder abrir sus archivos y entender:

- Que entendio de la solicitud.
- Que tablas creo y por que.
- Como se relacionan las tablas.
- Que datos de prueba uso.
- Que consultas responden al cliente.

## Reglas

- No suba archivos `.db`, `.sqlite`, `.sqlite3`, `.dump` ni datos pesados.
- No modifique el enunciado base.
- No copie respuestas de otros estudiantes.
- No deje archivos sueltos fuera de su carpeta personal.
- Su Pull Request debe apuntar a `dev`, nunca a `main`.

## Consejos

- Use nombres de tablas en plural y columnas claras.
- Evite guardar listas separadas por comas dentro de una sola columna.
- Prefiera tablas relacionadas antes que repetir datos.
- Pruebe primero con pocos datos y luego agregue mas casos.
- Si el cliente no especifica algo, documente su supuesto.

## Errores comunes

- Crear una sola tabla gigante para todo.
- Guardar informacion repetida en muchas filas.
- No usar `FOREIGN KEY` donde hay dependencia.
- Hacer `UPDATE` o `DELETE` sin `WHERE`.
- Crear consultas que no responden una pregunta del cliente.
- No explicar los supuestos del modelo.

## Pistas opcionales

- Piense en una tabla principal y una tabla de movimientos.
- Si una entidad aparece muchas veces, probablemente necesita su propia tabla.
- Si necesita contar, sumar o promediar, use columnas numericas reales.
- Si necesita historial, no borre: cambie estado o registre una fecha.

## Como validar

Ejecute en orden:

```bash
sqlite3 ejercicio-066.db < ddl/schema.sql
sqlite3 ejercicio-066.db < dml/inserts.sql
sqlite3 ejercicio-066.db < dml/operaciones.sql
sqlite3 ejercicio-066.db < dql/consultas.sql
```

El ejercicio queda bien si:

- Los scripts no fallan por errores de sintaxis.
- Las llaves foraneas evitan datos huerfanos.
- Las consultas devuelven informacion legible.
- El analisis escrito coincide con el SQL creado.
- El modelo resuelve la solicitud del cliente, no solo crea tablas al azar.
