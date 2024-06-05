# Usamos una imagen base oficial de Debian
FROM debian:latest

# Actualizamos la lista de paquetes y preinstalamos dependencias necesarias
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y autoconf gcc libc6 make wget unzip apache2 apache2-utils php libgd-dev openssl libssl-dev iptables-persistent

# Descargamos y compilamos Nagios Core
RUN cd /tmp && \
    wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz && \
    tar xzf nagioscore.tar.gz && \
    cd /tmp/nagioscore-nagios-4.4.14/ && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all && \
    make install-groups-users && \
    usermod -a -G nagios www-data && \
    make install && \
    make install-daemoninit && \
    make install-commandmode && \
    make install-config && \
    make install-webconf && \
    a2enmod rewrite && \
    a2enmod cgi && \
    htpasswd -bc /usr/local/nagios/etc/htpasswd.users nagiosadmin duoc.2024

# Descargamos e instalamos los plugins de Nagios
RUN cd /tmp && \
    wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.6.tar.gz && \
    tar zxf nagios-plugins.tar.gz && \
    cd /tmp/nagios-plugins-release-2.4.6/ && \
    ./tools/setup && \
    ./configure && \
    make && \
    make install

# Creamos un script de inicio para asegurar que Apache y Nagios se inicien al arrancar el contenedor
RUN echo "#!/bin/bash\nservice apache2 start\nservice nagios start\ntail -f /dev/null" > /usr/local/bin/start_services.sh && \
    chmod +x /usr/local/bin/start_services.sh

# Exponemos el puerto 80 para acceder al servicio web de Nagios
EXPOSE 80

# Establecemos el comando por defecto para ejecutar el script de inicio
CMD ["/usr/local/bin/start_services.sh"]
