# Pasos a Realizar con la aplicación en Django:

![04_-_image](https://user-images.githubusercontent.com/13952922/34891589-b47c3248-f79b-11e7-9899-ba3936134bc9.png)

***

- Hacer `python manage.py makemigrations`.
- Hacer `python manage.py migrate`.
- Modificar el `managed = False` a `True` de `Cliente`.
- Hacer `python manage.py makemigrations`.
- Hacer `python manage.py migrate`.
- Quitar los comentarios de `user` en `Cliente`.
- Hacer `python manage.py makemigrations`.
- Poner la **opción 1**.
- Poner como `default` `None`.
- Eliminar en `inicio/migrations/0003\*.py` que se agregue la columna `cp`.
- Hacer `python manage.py migrate`.
- Hacer `python manage.py createsuperuser` y crear un super usuario y ligarlo a un cliente.

## ¡Listo! :smiley::+1:
