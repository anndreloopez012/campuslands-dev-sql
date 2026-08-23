# Evidencias - Ejercicio 53

## Tema

NOT NULL

## Comandos ejecutados

```bash
sqlite3 ejercicio-53.db < ddl/schema.sql
sqlite3 ejercicio-53.db < dml/inserts.sql
sqlite3 ejercicio-53.db < dql/consultas.sql
```

## Resultados

**5.a Campo obligatorio (fecha_hora): ninguna cita queda sin fecha:**

```text
total_citas | citas_con_fecha
7           | 7
```

**5.b Campo opcional (correo): es normal que falten valores:**

```text
total_pacientes | pacientes_con_correo | pacientes_sin_correo
6                | 4                     | 2
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO pacientes (nombre, ...) VALUES (NULL, ...);` → `NOT NULL constraint failed: pacientes.nombre`.
- `INSERT INTO citas (..., fecha_hora) VALUES (..., NULL);` → `NOT NULL constraint failed: citas.fecha_hora`.

## Aprendizaje

`NOT NULL` no se trata de marcar todas las columnas como obligatorias por costumbre: se trata de identificar, para cada campo, si la fila tiene sentido de negocio sin el. `fecha_hora` en una cita es indispensable; `correo` en un paciente no lo es. La misma tabla (`pacientes`) puede tener campos obligatorios y opcionales al mismo tiempo, y la diferencia se nota inmediatamente al comparar `COUNT(*)` contra `COUNT(columna)`: si coinciden, la columna es efectivamente obligatoria en los datos; si no coinciden, confirma que el campo es legitimamente opcional.
