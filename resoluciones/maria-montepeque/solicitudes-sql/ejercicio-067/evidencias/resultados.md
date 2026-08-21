# Evidencias - Ejercicio 067

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-067.db < ddl/schema.sql
sqlite3 ejercicio-067.db < dml/inserts.sql
sqlite3 ejercicio-067.db < dml/operaciones.sql
sqlite3 ejercicio-067.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
artistas -> 4
canciones -> 6
usuarios -> 5
playlists -> 5
reproducciones -> 12
```

Caso que debe fallar - artista duplicado (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: artistas.nombre
```

Despues de `operaciones.sql`:

```text
playlist 5 estado: ('archivada',)     -- corregida, no eliminada
Cristina plan: ('premium',)            -- actualizada
reproducciones -> 11                    (se elimino el duplicado)
reproduccion 12: None                   -- eliminada correctamente
```

Caso que debe fallar - eliminar cancion con reproducciones asociadas (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de canciones por reproducciones):

```text
cancion               total_reproducciones
Blinding Lights        3
One More Time          3
Levitating              2
Dont Start Now          1
Callaita                1
Titi Me Pregunto        1
```

Consulta 5 (genero mas reproducido entre usuarios premium, HAVING > 1):

```text
genero          total_reproducciones
pop              6
electronica      3
```

## Explicacion final

El modelo separa catalogos (`artistas`, `canciones`, `usuarios`) de dos
tipos distintos de informacion cambiante: `playlists`, cuyo estado se
corrige en vez de borrarse (tal como pidio el cliente), y
`reproducciones`, un movimiento que si admite `DELETE` cuando es un
error de captura real (un duplicado exacto). Con `JOIN`, `GROUP BY` y
`HAVING` se responde exactamente lo que la plataforma necesita: que
cancion es mas popular y en que genero enfocar las recomendaciones para
sus usuarios premium.
