FROM alpine:3.19

# Upgrade Alpine
RUN apk update && apk upgrade

# MariaDB
RUN apk add --no-cache mariadb mariadb-client

# Start the Script
COPY tools/run.sh /run.sh
CMD ["/run.sh"]