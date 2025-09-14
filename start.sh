#!/bin/bash

/usr/sbin/php-fpm8.3 -F &
PHP_PID=$!

apache2ctl -DFOREGROUND &
APACHE_PID=$!

# Esperar a que uno de los procesos termine
wait -n $PHP_PID $APACHE_PID

# Si alguno falla, salir para que Docker reinicie el contenedor
exit 1  