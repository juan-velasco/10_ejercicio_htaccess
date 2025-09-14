FROM ubuntu:24.04

RUN apt-get -y update && apt-get install -y apache2 libapache2-mod-fcgid php8.3-fpm

RUN a2enmod proxy proxy_fcgi setenvif rewrite

COPY ./app.conf /etc/apache2/sites-available/app.conf

# Enable site
RUN a2ensite app

RUN mkdir -p /var/www/app
COPY ./index.php /var/www/app/
COPY ./index2.php /var/www/app/
COPY ./config.ini /var/www/app/
COPY .htaccess /var/www/app/

EXPOSE 80

# Ejecutar start.sh al iniciar el contenedor
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
