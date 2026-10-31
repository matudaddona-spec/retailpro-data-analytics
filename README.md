# Pre entregas de Martin D´addona

Proyecto del curso Data Analytics sobre RetailPro, una distribuidora de tecnología. Reúne los scripts SQL y los archivos de Power BI trabajados durante el curso.

## Herramientas

Microsoft SQL Server y SQL Server Management Studio (SSMS) para ejecutar SQL. Power BI Desktop, Power Query y DAX para preparar y modelar los datos. ChatGPT como apoyo para revisar consultas y documentar el trabajo.

## Ejecución de los scripts

Abrir SSMS, conectarse a una instancia de SQL Server y ejecutar los archivos de la raíz en este orden:

1. [ventas_tech_db.sql](ventas_tech_db.sql): crea la base Ventas_Tech_DB y carga las cuatro tablas.
2. [m4_consultas_negocio.sql](m4_consultas_negocio.sql): resumen mensual, ranking de productos y otras consultas de negocio.
3. [m5_consultas_joins.sql](m5_consultas_joins.sql): consultas con INNER JOIN, LEFT JOIN y UNION ALL.

Volver a ejecutar ventas_tech_db.sql borra y crea de nuevo las cuatro tablas. Si la base ya está cargada, se pueden ejecutar M4 y M5 sin repetir M3.

Las carpetas modulo-3, modulo-4 y modulo-5 contienen copias de los mismos scripts. Al ejecutar el proyecto, usar una sola copia de cada archivo.

## Archivos de Power BI

- [Módulo 6](modulo-6/): limpieza de datos con Power Query.
- [Módulo 8](modulo-8/Daddona_Martin_Checkpoint2.pbix): relaciones, calendario, medidas DAX y matriz de validación.

Los scripts SQL usan las 10 ventas de marzo de 2024 de M3. Power BI continúa con el Excel de M6, que tiene 50 ventas de 2023 y 2024. Son conjuntos de datos distintos y sus totales no deben mezclarse.

## Uso de IA

Se usó ChatGPT para preparar borradores de documentación y revisar consultas. Las sugerencias y las cifras se comprobaron con los datos del curso.
