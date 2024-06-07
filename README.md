Este contenedor esta basado en la imagen de DEBIAN.
Lo primero que hará el DOCKERFILE será actualizar los repositorios,
Luego instalara los paquetes necesarios para lanzar NAGIOS.
Descargara el NAGIOS CORE dentro de /tmp.
Extraera el archivo y comenzará compilando NAGIOS.#
Una vez compilado lo instalará utrilizando apache2 como usuario instalador.
Agregara al usuario nagios al grupo de apache2 (www-data).
Terminara instalando los ultimos detalles y actualizará la configuracion de apache para que publique /nagios
Creara el usuario nagiosadmin con contraseña duoc.2024 (puedes modificar esto a tu gusto)
Al terminar con nagios realizará la instalación de los plugins para poder monitorear su propio host.
Creara un archivo llamado "start_service.sh" para iniciar los servicios de nagios y apache siempre que inicie el contenedor.
Expondra el contenedor al puerto 80.
Y generará un inicio de "start_service.sh" cada vez que se inicie el contenedor.

##GUIA RAPIDA DE DESPLIEGUE.
#Descarga:
```
git clone https://github.com/luherre/nagios_luherrera.git
```
#Cambiar a directorio
```
cd nagios_luherrera
```
#Ejecutar la build de nagios, puedes editar el dockerfile para establecer el usuario y pass
```
docker build -t NOMBRE .
```
#Ejecutar imagen:
```
docker run -it -d -p 0.0.0.0:80:80 NOMBRE
```
#Acceso a nagios TUIP es la ip de tu servidor.
```
http://TUIP/nagios
```
#Credenciales
```
user: nagiosadmin
pass: duoc.2024
```

##EXTRAS
#Puedes copiar el archivo linux_host.cfg y pegarlo dentro del contenedor, editale la dirección IP del servidor.
```
docker cp linux_host.cfg nagios_container_id:/usr/local/nagios/etc/objects/
```
#Luego añades el archivo a la configuracion de nagios.
```
cfg_file=/usr/local/nagios/etc/objects/linux_host.cfg
```

##PARA TENER UN VOLUMEN DEL CONTENEDOR Y LOS ARCHIVOS LOCALES UTILIZA LO SIGUIENTE COMANDO
```
docker run -it -d -p 0.0.0.0:80:80 -v /rutadetusobjects:/usr/local/nagios/etc/objects NOMBRE
```
