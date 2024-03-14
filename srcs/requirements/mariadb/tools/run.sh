#!/bin/sh

# # Create the Socket Directory
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
    echo "[-] Waiting on MariaDb..."
fi

# if Database Not Created ( in Volume ) ---> Create it
if [ ! -d "/var/lib/mysql/mysql" ]; then

    # Grant Access
	chown -R mysql:mysql /var/lib/mysql

    # Install
	mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db --rpm                             >> /dev/null

    # Reload privilegem
    echo "FLUSH PRIVILEGES;"                                                                                > temp.sql

    # Set mysql as the default database
    echo "USE mysql;"                                                                                       >> temp.sql
    
    # Remove the Ghost Users 
    echo "DELETE FROM mysql.user WHERE User='';"                                                            >> temp.sql
    
    # Disable Remote access to root
    echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"      >> temp.sql
    
    # Change Root Password
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'noaccess';"                                          >> temp.sql
    
    # Create Database & Set Character as utf-8
    echo "CREATE DATABASE $DATABASE_NAME CHARACTER SET utf8;"                                               >> temp.sql
    
    # Create New Admin
    echo "CREATE USER '$DATABASE_ADMIN'@'%' IDENTIFIED by '$DATABASE_ADMIN_PW';"                            >> temp.sql
    
    # Grant Privilege to Admin
    echo "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_ADMIN'@'%';"                               >> temp.sql
    
    # Reload privileges
    echo "FLUSH PRIVILEGES;"                                                                                >> temp.sql

    # Throw the commands in MYSQL
    /usr/bin/mysqld --user=mysql --bootstrap < temp.sql

    # Delete Temp file
    rm -rf temp.sql

fi

# PHP-FPM Config file
echo "[mysqld]\n#skip-networking\n[galera]\nbind-address=0.0.0.0\n[embedded]\n[mariadb]\n[mariadb-10.5]" > /etc/my.cnf.d/mariadb-server.cnf

# Start
echo "[+] MariaDB Started !"
exec mysqld_safe