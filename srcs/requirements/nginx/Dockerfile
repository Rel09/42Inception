FROM debian:buster

# Upgrade Debian
RUN apt update && apt upgrade
RUN apt install -y apt-utils

# Prerequises
RUN apt install -y nginx openssl

# Install SSL/TLS Cert & Key
RUN openssl req -x509 -nodes -days 15 -newkey rsa:4096 -out /etc/ssl/certs/server.crt -keyout /etc/ssl/private/server.key -subj "/C=CA/ST=QC/L=QC/O=42/CN=localhost" -sha256

# NGINX Config File
RUN echo "root /var/www/html;\n\
server {\n\
    listen 443 ssl;\n\
    listen [::]:443 ssl;\n\
    server_name dpotvin.42.fr;\n\
    ssl_protocols TLSv1.2 TLSv1.3;\n\
    ssl_certificate /etc/ssl/certs/server.crt;\n\
    ssl_certificate_key /etc/ssl/private/server.key;\n\
    index index.php;\n\
    location / {\n\
        autoindex on;\n\
        autoindex_format html;\n\
        try_files \$uri \$uri/ =404;\n\
    }\n\
    location /static {\n\
        try_files /static.html =404;\n\
    }\n\
    location ~ \.php$ {\n\
        include snippets/fastcgi-php.conf;\n\
        fastcgi_pass wordpress:9000;\n\
    }\n\
}" > etc/nginx/sites-enabled/default

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]