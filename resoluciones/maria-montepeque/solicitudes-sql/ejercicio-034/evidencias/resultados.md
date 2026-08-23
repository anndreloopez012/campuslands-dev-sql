# Evidencias - Solicitudes SQL - Ejercicio 034 (Estudio Animacion 3D)

## Comandos ejecutados

```bash
sqlite3 ejercicio-034.db < ddl/schema.sql
sqlite3 ejercicio-034.db < dml/inserts.sql
sqlite3 ejercicio-034.db < dml/operaciones.sql
sqlite3 ejercicio-034.db < dql/consultas.sql
```

## Resultados

**1. Todos los proyectos, con JOIN doble a clientes y artistas (ya sin el duplicado y con la textura de Andes en progreso):**

```text
id_proyecto | nombre_cliente        | nombre_artista  | nombre_proyecto                   | fecha_entrega | presupuesto | estado
1           | Estudio Nova Films    | Mario Lux       | Trailer Nova - Escena 1           | 2026-08-05    | 4500.0      | finalizado
2           | Pixel Forge Studios   | Sofia Vera      | Personaje Principal Pixel Forge   | 2026-08-10    | 6800.0      | en_progreso
3           | Andes Interactive     | Diego Ruiz      | Texturas Mapa Andes               | 2026-08-08    | 3100.0      | en_progreso
4           | Estudio Nova Films    | Paula Ixchel    | Iluminacion Trailer Nova          | 2026-08-12    | 2800.0      | pendiente
5           | Luna Producciones     | Mario Lux       | Comercial Luna 30s                | 2026-08-15    | 5200.0      | en_revision
6           | Quetzal Games         | Carlos Mendez   | Cinematica Quetzal Nivel 1        | 2026-08-20    | 7800.0      | en_progreso
7           | Pixel Forge Studios   | Diego Ruiz      | Texturas Personaje Pixel Forge    | 2026-08-11    | 1900.0      | finalizado
8           | Andes Interactive     | Sofia Vera      | Modelado Escenario Andes          | 2026-08-09    | 3600.0      | pendiente
9           | Pixel Forge Studios   | Mario Lux       | Modelado Personaje Secundario     | 2026-08-18    | 3300.0      | pendiente
```

Quedan 9 proyectos (empezaron 10, se elimino el duplicado del `id_proyecto = 10`).

**2. Proyectos que no estan finalizados todavia:**

```text
id_proyecto | id_cliente | id_artista | presupuesto | estado
2           | 2          | 2          | 6800.0      | en_progreso
3           | 3          | 3          | 3100.0      | en_progreso
4           | 1          | 4          | 2800.0      | pendiente
5           | 4          | 1          | 5200.0      | en_revision
6           | 5          | 5          | 7800.0      | en_progreso
8           | 3          | 2          | 3600.0      | pendiente
9           | 2          | 1          | 3300.0      | pendiente
```

**3. Artista con mas proyectos asignados en total:**

```text
nombre_artista | total_proyectos
Mario Lux      | 3
Diego Ruiz     | 2
Sofia Vera     | 2
Carlos Mendez  | 1
Paula Ixchel   | 1
```

**4. Proyectos ordenados por fecha de entrega:** ver tabla completa arriba, de 2026-08-05 a 2026-08-20.

**5. Carga de trabajo activa por artista (pendiente, en_progreso o en_revision), para decidir a quien asignar el siguiente proyecto:**

```text
nombre_artista | proyectos_activos
Mario Lux      | 2
Sofia Vera     | 2
Carlos Mendez  | 1
Diego Ruiz     | 1
Paula Ixchel   | 1
```

Mario Lux y Sofia Vera ya tienen 2 proyectos activos cada uno; Carlos Mendez, Diego Ruiz y Paula Ixchel solo tienen 1. Con este reporte el estudio puede decidir asignar el siguiente proyecto nuevo a alguno de los tres con menos carga.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO proyectos (..., presupuesto) VALUES (..., 0);` → `CHECK constraint failed: presupuesto > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE proyectos SET estado = 'en_progreso' WHERE id_proyecto = 3 AND estado = 'pendiente';` → las texturas del mapa de Andes pasaron de `pendiente` a `en_progreso`.
- `UPDATE proyectos SET presupuesto = 6800.00 WHERE id_proyecto = 2;` → el presupuesto del personaje principal de Pixel Forge subio de 6200.00 a 6800.00.
- `DELETE FROM proyectos WHERE id_proyecto = 10;` → el proyecto duplicado desaparecio; el conteo final es 9, no 10.

## Aprendizaje

Con `artistas` como tabla real (no como texto dentro del proyecto), el reporte de carga de trabajo (consulta 5) queda protegido contra el problema que le importa al cliente para su decision semanal: si "Mario Lux" se escribiera con una variacion minima en un proyecto, el reporte lo contaria como una persona distinta y su carga real quedaria subestimada. La `FOREIGN KEY` obliga a que cada proyecto apunte siempre al mismo `id_artista`, garantizando que el conteo de carga activa sea confiable para tomar la decision de a quien asignar el siguiente trabajo.
