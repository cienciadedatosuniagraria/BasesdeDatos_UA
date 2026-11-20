# Bases de datos · Anexos de las actividades

Curso **Bases de datos** · Profesional en Ciencia de Datos · UNIAGRARIA, Dirección de Educación Virtual.

Este repositorio reúne los archivos de apoyo de las cuatro actividades del curso. Todas trabajan sobre el caso **AgroDatos**, una cooperativa agrícola ficticia de la Sabana de Bogotá. Los datos de los archivos son ficticios.

| Actividad | Archivos | Uso |
|---|---|---|
| [Actividad 1](Actividad1) · Modelando el control de insumos de AgroDatos | `Anexo_A1_Plantilla_diccionario_de_datos.xlsx` | Plantilla para documentar las tablas nuevas del modelo. |
| [Actividad 2](Actividad2) · AgroDatos en SQL | `Anexo_A2_agrodatos_postgresql.sql`, `Anexo_A2_agrodatos_mysql.sql` | Script base: crea las siete tablas con sus restricciones y carga datos de ejemplo. Use el del gestor que haya elegido. |
| [Actividad 3](Actividad3) · Plan de administración de AgroDatos | `Anexo_A3_ventas_sinteticas_postgresql.sql`, `Anexo_A3_ventas_sinteticas_mysql.sql` | Carga 100 000 ventas sintéticas sobre la base de la Actividad 2 para medir planes de ejecución. |
| [Actividad 4](Actividad4) · AgroDatos 360 | `Anexo_A4_cuaderno_inicio_AgroDatos360.ipynb` | Cuaderno de Jupyter de inicio: conexiones a PostgreSQL y MongoDB y generador de lecturas de sensores. |

## Cómo descargar un archivo

Abra la carpeta de la actividad, haga clic en el archivo y use el botón **Download raw file** (ícono de descarga) en la parte superior derecha. Si prefiere descargar todo el repositorio, use **Code → Download ZIP** en la página principal.

## Versiones de referencia

PostgreSQL 16, MySQL 8.0, MongoDB 7.0, Python 3.10 o superior, SQLAlchemy 2.0, PyMongo 4 y pandas 2.

## Recomendaciones

- Ejecute los scripts en una base de datos de práctica. El script base elimina y vuelve a crear la base `agrodatos` (MySQL) o el esquema `agro` (PostgreSQL).
- Nunca escriba usuarios ni contraseñas dentro de los cuadernos o los scripts que entregue: use variables de entorno, como muestra el cuaderno de la Actividad 4.
