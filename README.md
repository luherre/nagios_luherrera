#nagios_luherrera
Descarga y compilacion de imagen de nagios.

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
