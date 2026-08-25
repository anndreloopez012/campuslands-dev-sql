# Evidencias - Ejercicio 88

## Tema

ORDER BY

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-88.db < ddl/schema.sql
sqlite3 ejercicio-88.db < dml/inserts.sql
sqlite3 ejercicio-88.db < dql/consultas.sql
```

## Resultados

**Caso comentado verificado:**

- La consulta 1 (`SELECT ... ORDER BY 9`) → `1st ORDER BY term out of range - should be between 1 and 6` (esa consulta solo tiene 6 columnas).

**5. Tabla de posiciones del torneo (reporte final, nivel aplicado):**

```text
nombre_equipo          puntos   goles_favor   goles_contra
Dragones del Norte       7          6              2
Halcones del Centro      4          3              4
Tigres del Oeste         2          3              3
Lobos del Sur            0          1              4
```

Verificacion manual:

- Dragones del Norte: gano 2 (3-1 vs Lobos, 2-0 vs Halcones), empato 1 (1-1 vs Tigres) = 3+3+1 = 7 puntos; goles a favor 3+2+1=6, en contra 1+0+1=2.
- Halcones del Centro: empato 1 (2-2 vs Tigres), gano 1 (1-0 vs Lobos), perdio 1 (0-2 vs Dragones) = 1+3+0 = 4 puntos; GF 2+1+0=3, GC 2+0+2=4.
- Tigres del Oeste: empato 2 (2-2 vs Halcones, 1-1 vs Dragones) = 1+1 = 2 puntos; GF 2+1=3, GC 2+1=3.
- Lobos del Sur: perdio 2 (1-3 vs Dragones, 0-1 vs Halcones) = 0 puntos; GF 1+0=1, GC 3+1=4.

El orden final coincide exactamente: Dragones domina por puntos, y
como ningun equipo empata en puntos con otro, el segundo criterio
(diferencia de goles) no llego a usarse esta vez, pero esta listo
para desempatar si hiciera falta.

## Aprendizaje

El `ORDER BY` de este reporte usa tres criterios en cascada, tal como
una tabla de posiciones real: `puntos DESC` primero, despues
`(goles_favor - goles_contra) DESC`, y por ultimo `nombre_equipo ASC`
como desempate final. SQLite permite referenciar los alias definidos
en el `SELECT` (`puntos`, `goles_favor`, `goles_contra`) dentro del
`ORDER BY`, incluso combinandolos en una operacion aritmetica nueva
(`goles_favor - goles_contra`), sin tener que repetir las
subconsultas completas. El caso comentado confirma que ordenar por
posicion numerica sigue siendo fragil: la consulta 1 solo devuelve 6
columnas, y pedir `ORDER BY 9` la hace fallar de inmediato.
