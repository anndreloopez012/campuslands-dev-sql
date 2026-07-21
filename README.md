# Campuslands Dev SQL

Repositorio publico de ejercicios de SQL para practicar diseno, creacion, insercion, actualizacion, eliminacion y consulta de bases de datos relacionales.

Este repositorio esta preparado para que los estudiantes hagan fork, trabajen desde `dev`, creen su propia rama y envien Pull Request hacia `dev`.

## Objetivo

Fortalecer las habilidades necesarias para:

- Analizar requerimientos de una base de datos.
- Identificar entidades, atributos, relaciones y restricciones.
- Crear modelos relacionales con llaves primarias y foraneas.
- Implementar estructuras con SQL.
- Insertar datos de prueba.
- Actualizar datos con `UPDATE`.
- Eliminar datos de forma controlada con `DELETE`.
- Ejecutar consultas usando DQL.
- Crear reportes con filtros, ordenamientos, agrupaciones y `JOIN`.
- Documentar evidencias tecnicas de forma clara.

## Flujo de trabajo con Git

Para una explicacion completa del proceso de entrega, revise:

[FLUJO-DE-ENTREGA.md](FLUJO-DE-ENTREGA.md)

El repositorio tiene dos ramas principales protegidas:

- `main`: rama estable. No se trabaja directamente sobre esta rama.
- `dev`: rama base de desarrollo e integracion. Todos los Pull Requests de estudiantes deben apuntar a esta rama.

Regla de trabajo:

1. Hacer fork del repositorio publico.
2. Cambiarse siempre a `dev` antes de crear una rama.
3. Crear una rama personal desde `dev`.
4. Hacer commits pequenos y descriptivos.
5. Subir la rama al fork.
6. Abrir Pull Request hacia `dev` del repositorio original.
7. Promover a `main` solo cuando el instructor lo indique.

Ejemplo:

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-01
```

El repositorio incluye un hook local en `.githooks/pre-commit` para bloquear commits directos en `main`, `master` o `dev`. Para activarlo despues de clonar:

```bash
git config core.hooksPath .githooks
```

## Estructura

```text
campuslands-dev-sql/
├── README.md
├── CONTRIBUTING.md
├── FLUJO-DE-ENTREGA.md
├── .github/
│   ├── CODEOWNERS
│   ├── branch-protection.md
│   └── pull_request_template.md
├── ejercicios/
│   ├── README.md
│   ├── 01-cinemax-sqlite/
│   ├── 02-campus-shop/
│   └── ... 109 ejercicios
└── resoluciones/
    └── README.md
```

Cada ejercicio tiene:

```text
ejercicios/XX-nombre/
├── README.md
└── plantilla/
    ├── diagramas/
    ├── ddl/
    │   └── schema.sql
    ├── dml/
    │   ├── inserts.sql
    │   └── operaciones.sql
    └── dql/
        └── consultas.sql
```

Los ejercicios 41 al 109 agregan tambien una carpeta `evidencias/` para registrar resultados.

Los ejercicios de normalizacion agregan tambien:

```text
plantilla/
├── analisis/
│   └── normalizacion.md
└── datos/
    └── datos-sin-normalizar.csv
```

## Ejercicios incluidos

Hay 109 ejercicios progresivos:

```text
01 CineMax SQLite
02 Campus Shop
03 Biblioteca Tech
04 Restaurante Campus
05 Inventario de Bicicletas
06 Torneo Esports
07 Academia de Cursos
08 Clinica de Citas
09 Gimnasio Membresias
10 Hotel Reservas
11 Transporte Rutas
12 Streaming Musica
13 Banco Cuentas
14 Marketplace Campus
15 Taller de Motos
16 Aerolinea Vuelos
17 Red Social Campus
18 Farmacia Inventario
19 Universidad Notas
20 Eventos Boletos
21 Logistica Envios
22 Pedidos Delivery
23 Facturacion Simple
24 Recursos Humanos
25 Reportes Biblioteca
26 Normalizacion Tienda
27 Indices y Busquedas
28 Vistas y Reportes
29 Transacciones Reservas
30 Proyecto Integrador SQL
31 Normalizacion Ventas Campus
32 Normalizacion Pedidos Restaurante
33 Normalizacion Matriculas Academicas
34 Normalizacion Clinica Tratamientos
35 Normalizacion Inventario Proveedores
36 Normalizacion Hotel Reservas
37 Normalizacion Biblioteca Multiautor
38 Normalizacion Ecommerce Envios
39 Normalizacion Recursos Humanos
40 Normalizacion Integrador Avanzado
41 Tipos de datos Nivel Basico
42 Tipos de datos Nivel Intermedio
43 Tipos de datos Nivel Aplicado
44 PRIMARY KEY Nivel Basico
45 PRIMARY KEY Nivel Intermedio
46 PRIMARY KEY Nivel Aplicado
47 FOREIGN KEY Nivel Basico
48 FOREIGN KEY Nivel Intermedio
49 FOREIGN KEY Nivel Aplicado
50 UNIQUE Nivel Basico
51 UNIQUE Nivel Intermedio
52 UNIQUE Nivel Aplicado
53 NOT NULL Nivel Basico
54 NOT NULL Nivel Intermedio
55 NOT NULL Nivel Aplicado
56 CHECK Nivel Basico
57 CHECK Nivel Intermedio
58 CHECK Nivel Aplicado
59 DEFAULT Nivel Basico
60 DEFAULT Nivel Intermedio
61 DEFAULT Nivel Aplicado
62 AUTO_INCREMENT Nivel Basico
63 AUTO_INCREMENT Nivel Intermedio
64 AUTO_INCREMENT Nivel Aplicado
65 ALTER TABLE Nivel Basico
66 ALTER TABLE Nivel Intermedio
67 ALTER TABLE Nivel Aplicado
68 DROP Nivel Basico
69 DROP Nivel Intermedio
70 DROP Nivel Aplicado
71 INSERT Nivel Basico
72 INSERT Nivel Intermedio
73 INSERT Nivel Aplicado
74 UPDATE Nivel Basico
75 UPDATE Nivel Intermedio
76 UPDATE Nivel Aplicado
77 DELETE Nivel Basico
78 DELETE Nivel Intermedio
79 DELETE Nivel Aplicado
80 SELECT Nivel Basico
81 SELECT Nivel Intermedio
82 SELECT Nivel Aplicado
83 WHERE Nivel Basico
84 WHERE Nivel Intermedio
85 WHERE Nivel Aplicado
86 ORDER BY Nivel Basico
87 ORDER BY Nivel Intermedio
88 ORDER BY Nivel Aplicado
89 GROUP BY Nivel Basico
90 GROUP BY Nivel Intermedio
91 GROUP BY Nivel Aplicado
92 HAVING Nivel Basico
93 HAVING Nivel Intermedio
94 HAVING Nivel Aplicado
95 JOIN Nivel Basico
96 JOIN Nivel Intermedio
97 JOIN Nivel Aplicado
98 Vistas Nivel Basico
99 Vistas Nivel Intermedio
100 Vistas Nivel Aplicado
101 Procedimientos almacenados Nivel Basico
102 Procedimientos almacenados Nivel Intermedio
103 Procedimientos almacenados Nivel Aplicado
104 Triggers Nivel Basico
105 Triggers Nivel Intermedio
106 Triggers Nivel Aplicado
107 Indices Nivel Basico
108 Indices Nivel Intermedio
109 Indices Nivel Aplicado
```

Consulte el listado navegable en [ejercicios/README.md](ejercicios/README.md).

## Como trabajar un ejercicio

1. Haga fork del repositorio.
2. Clone su fork.
3. Cambiese a `dev`.
4. Cree una rama personal desde `dev`.
5. Lea completamente el enunciado en `ejercicios/<numero>-<nombre>/README.md`.
6. Copie la carpeta `plantilla/` dentro de `resoluciones/apellido-nombre/ejercicio-XX/`.
7. Complete los archivos solicitados.
8. Ejecute los scripts SQL en SQLite.
9. Haga commit y push a su rama.
10. Abra Pull Request hacia `dev`.

Ejemplo:

```bash
git clone https://github.com/TU-USUARIO/campuslands-dev-sql.git
cd campuslands-dev-sql
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-01
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/01-cinemax-sqlite/plantilla resoluciones/apellido-nombre/ejercicio-01
```

Despues de resolver:

```bash
git status
git add resoluciones/apellido-nombre/ejercicio-01
git commit -m "feat(sql): resolver ejercicio 01"
git push -u origin alumno/apellido-nombre/ejercicio-01
```

En GitHub:

```text
base: dev
compare: alumno/apellido-nombre/ejercicio-01
```

No se aceptan Pull Requests hacia `main`.

## Ramas protegidas

- `main` esta protegida como rama estable.
- `dev` esta protegida como rama de integracion.
- Los estudiantes no deben hacer push directo a `main` ni `dev`.
- Los estudiantes trabajan en ramas propias desde `dev`.
- Los Pull Requests deben apuntar siempre a `dev`.
- `CODEOWNERS` solicita revision del owner.

La guia de configuracion de proteccion esta en [.github/branch-protection.md](.github/branch-protection.md).

## Requisitos recomendados

- Git
- SQLite 3
- Extensiones opcionales para visualizar bases de datos SQLite
- Herramienta para diagramas E-R, por ejemplo Draw.io, Lucidchart, Mermaid o similar

## Convenciones

- Los nombres de carpetas deben ir en minuscula y con guiones.
- Los archivos SQL deben terminar en `.sql`.
- Las soluciones deben poder ejecutarse desde cero en una base de datos vacia.
- No se deben subir archivos generados innecesarios como bases de datos locales, caches o capturas temporales.
- Las soluciones van en `resoluciones/apellido-nombre/ejercicio-XX/`.
- Los enunciados en `ejercicios/` no se modifican.
