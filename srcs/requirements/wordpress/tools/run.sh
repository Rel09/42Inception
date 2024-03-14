#!/bin/sh

# Waiting for MariaDB
while ! mariadb -hmariadb -u$DATABASE_ADMIN -p$DATABASE_ADMIN_PW $DATABASE_NAME; do
    echo "[-] Waiting on MariaDB to start..."
    sleep 3
done

# if Wordpress Not Installed ( in Volume ) ---> Install
if [ ! -f "/var/www/html/wp-config.php" ]; then

    # Download Wordpress
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

    # Get in Wordpress Folder
    cd /var/www/html

    # Password Policy
    chmod +x password.sh && ./password.sh && rm -rf password.sh
    
    # Install Wordpress
    wp core download --allow-root

    # Create Config File
    wp config create --dbname="${DATABASE_NAME}" --dbuser="${DATABASE_ADMIN}" --dbpass="${DATABASE_ADMIN_PW}" --dbhost=mariadb --dbcharset="utf8" --allow-root
    
    # Install Wordpress Core & Admin user
    wp core install --url="dpotvin.42.fr" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USR}" --admin_password="${WP_ADMIN_PWD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root
    
    # Creater user [Author]
    wp user create "${WP_USER_USR}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PWD}" --allow-root

    # Install Theme
    wp theme install bizboost --activate --allow-root

fi

# Create PHP ProcessID Folder
mkdir /run/php && chown www-data:www-data /run/php

# Start PHP-FPM
echo "[+] Wordpress & PHP_FPM is Running !"
exec /usr/sbin/php-fpm7.3 --nodaemonize