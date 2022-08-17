uname_S := $(shell uname -s)

all: build up

build:
	docker-compose down -v
	docker-compose build
	@echo "Application has been built succesfully."

up:
	docker-compose down -v
	docker-compose up -d

cli:
	docker-compose run --rm app bash

logs:
	docker-compose logs -f