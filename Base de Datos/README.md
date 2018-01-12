# **Instrucciones para la creación de la Base de Datos:**
![385695-636398764837395889-16x9](https://user-images.githubusercontent.com/13952922/34891409-1a6a8894-f79b-11e7-9de1-000c9314d323.jpg)

***

Nos refriremos a continuación al directorio `ProyectoFinal/Base de Datos/src`
***

## **Pasos (Se supone instalado y ya creado un nuevo usuario en SQLDeveloper):**

1. Ir a la carpeta `DDL y DML`:
  - Usar el script `DDL y DML/DDL_creación.sql`.
  - Usar el script `DDL y DML/DDL_restricciones.sql`.
  
2. Compilas los disparadores ("triggers") de la carpeta `Disparadores`. 
   No importa el orden de compilación:
  - `Disparadores/trigger_histórico.sql`.
  - `Disparadores/trigger_ingredientes.sql`.
  - `Disparadores/trigger_puntos.sql`.
  - `Disparadores/trigger_taquegoria.sql`.
  - `Disparadores/trigger_taquegoria_salsa.sql`.
  - `Disparadores/trigger_update_fecha_promoción.sql`.
  
3. Hacer lo respectivo con los procedimientos almacenados ("stored procedures") de la carpeta `Procedimientos Almacenados`.
  - `Procedimientos Almacenados/sp_elimina_caduco.sql`.
  - `Procedimientos Almacenados/sp_incrementa_salario.sql`.
  
4. Poblar la base de datos con el archivo ubicado en `Poblado`:
  - `Poblado/poblado.sql`.
  
5. Luego, será posible probar las consultas:
  - `DDL y DML/DML_consultas.sql`.
  
6. Opcionalmente borrar todo con el archivo de la carpeta `DDL Y DML`:
  - `DDL y DML/DDL_borrado.sql`.
