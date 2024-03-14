FROM debian:buster

# Upgrade Debian
RUN apt update && apt upgrade
RUN apt install -y apt-utils

# Prerequises
RUN apt install -y mariadb-client wget php7.3 php-mysqli php-fpm

# PHP-FPM Config file
RUN echo "[www]\nuser = www-data\ngroup = www-data\nlisten = 0.0.0.0:9000\nlisten.owner = www-data\nlisten.group = www-data\npm = dynamic\npm.max_children = 25\npm.start_servers = 5\npm.min_spare_servers = 1\npm.max_spare_servers = 10" > /etc/php/7.3/fpm/pool.d/www.conf

# Password Policy Script
COPY tools/password.sh /var/www/html/password.sh

# Static Page ( Bonus )
COPY tools/static.html /var/www/html/
RUN chmod 777 /var/www/html/static.html

# Copy & Run Script
COPY tools/run.sh /run.sh
CMD ["/run.sh"]