TERMINAL=/bin/sh
DC_PATH="./srcs/docker-compose.yml"

# Change the Volume path inside the Docker-Compose too
WP_VOLUME_PATH="/home/rel09/data/wp"
DB_VOLUME_PATH="/home/rel09/data/db"



# Normal stuff you would use
build:
	@docker-compose -f $(DC_PATH) build

start:
	@docker-compose -f $(DC_PATH) up -d

stop:
	@docker-compose -f $(DC_PATH) down



# But im Lazy af
run:
	@docker-compose -f $(DC_PATH) build
	@docker-compose -f $(DC_PATH) up -d



# Status / Logs
check:
	@docker-compose -f $(DC_PATH) ps

log:
	@docker-compose -f $(DC_PATH) logs


# Enter inside the Dockers
nginx:
	@docker exec -it nginx_cont $(TERMINAL)

mariadb:
	@docker exec -it mariadb_cont $(TERMINAL)

wordpress:
	@docker exec -it wordpress_cont $(TERMINAL)




# Wipe EVERYTHING
fclean:
	@docker-compose -f $(DC_PATH) down -v --rmi all --remove-orphans --timeout 0 || true
	@docker system prune -af || true
	@rm -rf $(WP_VOLUME_PATH)/* 
	@rm -rf $(DB_VOLUME_PATH)/*

# Wipe EVERYTHING and Restart
reset: fclean run
