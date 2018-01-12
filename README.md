# Proyecto Final 
## Fundamentos de Bases de Datos (FBD Semestre 2018-1)
### Facultad de Ciencias, UNAM.
![logo_proyecto](https://user-images.githubusercontent.com/13952922/34808438-99e9657e-f654-11e7-8aae-cf15991360de.jpg)

***
**Proyecto para la taquería Tacoste realizada por Computólogos A.C. consistente de una base de datos para un manejo escalable y útil de sus:**

- Sucursales
- Empleados
- Clientes
- Proveedores
- Productos y Salsas
- Pedidos
***

Se espera que el sistema desarrollado por la empresa Computólogos
A.C. pueda fungir como una herramienta que permita al señor José Cruz
llevar a cabo su proyecto de expansión con respecto a la cadena mexicana
de tacos Tacoste, que además sea escalable y permita controlar sucursales
a lo largo y ancho de la República Mexicana. 

A través de las posibilidades económicas del cliente en cuestión y las contingencias de mercado se anhela
brindarle una solución similar al software que poseen franquicias de tacos
modernas, mismos que permiten la creación de menús dirigidos y promociones para sectores especı́ficos y que eventualmente conduzcan a la empresa a
ser competitiva en el mercado y lograr alianzas comerciales que la beneficien.
Especı́ficamente, se desea:

- Con tal de poder eventualmente conocer el momento de sacar promo-
ciones, poder llevar un registro histórico de los precios y productos de
la taquerı́a.
- Otorgar tickets por cada consumo.
- Minimizar los desperdicios de las sucursales, identificando para esto la
cantidad aproximada de porciones de ingredientes a comprar o prepa-
rar para vender.
- Implementar un sistema de puntos que permitan a clientes frecuentes
intercambiar por productos dentro de la taquerı́a sus puntos generados
a raı́z de sus compras previas.
- Tener la posibilidad de manejar promociones ciertos dı́as de la semana.
- Poder ofrecerle a los clientes un sistema de envı́o a domicilio y tener
un sistema de ventas en lı́nea de sus reconocidas salsas.
Ofrecer a los clientes presentar distintas formas de pago.
- Identificar a los empleados con una antigüedad de cinco años para
ofrecerles un bono especial de mil pesos 00/100 M.N.
- Tener un control de inventarios para los productos y los ingredientes
que los componen.

_Nota: Revisar análisis_de_requerimientos.pdf en `Proyecto/Base de Datos/Documentos/análisis_de_requerimientos.pdf` para ahonda más en la especificación y decisiones tomadas por la empresa._

---

**La estructura del proyecto es la siguiente:**

```
ProyectoFinalFBD
│   
└───Aplicación
│     file021.txt
│     file022.txt
│      
└───Base de Datos
│   │   
│   └───Diagramas	
│   │       ER.dia
│   │       ER.png
│   │       UML_no_normalizado.dia
│   │       UML_no_normalizado.png
│   │       UML_normalizado.dia
│   │       UML_normalizado.png
│   │
│   └───Documentos
│   │       análisis_requerimientos.pdf
│   │       aviso_privacidad.pdf
│   │       diagrama_entidad_relación.pdf
│   │       diccionario_de_datos.pdf
│   │       modelo_relacional.pdf
│   │       normalización.pdf
│   │
│   └───Especifiación
│   │       MenuTacoste.pdf
│   │       ProyectoFinal2018-1.pdf
│   │
│   └───LaTeX
│   │       │
│   │       └───Análisis de Requerimientos (Decisiones de Diseño)
│   │       │       análisis_requerimientos.aux
│   │       │ 		análisis_requerimientos.pdf
│   │       │	    análisis_requerimientos.synctex.gz
│   │       │ 		análisis_requerimientos.tex
│   │       │       análisis_requerimientos.toc
│   │       │       logo.png
│   │       │
│   │       └───Entidad-Relación
│   │       │ 		ER.png
│   │       │ 		diagrama_entidad_relación.aux
│   │       │		diagrama_entidad_relación.pdf
│   │       │ 		diagrama_entidad_relación.synctex.gz
│   │       │       diagrama_entidad_relación.tex
│   │       │       logo.png
│   │       │
│   │       └───Modelo Relacional
│   │       │ 		UML_no_normalizado.png
│   │       │ 		logo.png
│   │       │	    modelo_relacional.aux
│   │       │ 		modelo_relacional.pdf
│   │       │       modelo_relacional.synctex.gz
│   │       │       modelo_relacional.synctex.gz
│   │       │       modelo_relacional.toc
│   │       │
│   │       └───Normalización
│   │        		1NF.png
│   │        		2NF.png
│   │       		UML_no_normalizado.png
│   │        		UML_normalizado.png
│   │               logo.png
│   │               normalización.aux
│   │               normalización.dvi
│   │               normalización.pdf
│   │               normalización.synctex.gz
│   │               normalización.tex
│   │               normalización.toc
│   │
│   └───Logos
│   │     logo_computólogos.png
│   │     logo_tacoste.png
│   │
│   └───src
│        └───DDL y DML
│        │      DDL_borrado.sql
│        │ 		DDL_creación.sql
│        │	    DDL_restricciones.sql
│        │ 		DML_consultas.sql
│        │
│        └───Disparadores
│        │ 		trigger_histórico.sql
│        │ 		trigger_ingredientes.sql
│        │		trigger_puntos.sql
│        │ 		trigger_taquegoria.sql
│        │      trigger_taquegoria_salsa.sql
│        │      trigger_update_fecha_promoción.sql
│        │
│        └───Poblado
│        │ 		poblado.sql
│        │
│        └───Procedimientos Almacenados
│           	sp_elimina_caduco.sql
│           	sp_incrementa_salario.sql
│
│        README.md
│
│  README.md      
```
