VOLUME=$(shell basename $(PWD))

develop: clean build migrations.all run

clean:
	docker-compose rm -vf

build:
	docker-compose build

run:
	docker-compose up

shell:
	docker-compose run django \
	  sh

python-shell:
	docker-compose run django \
	  poetry run python manage.py shell

postgres.data.delete: clean
	docker volume rm $(VOLUME)_postgres

# fix this
# postgres.start:
# 	docker-compose up -d postgres
# 	docker-compose exec postgres \
# 	  sh -c 'while ! nc -z postgres 5432; do sleep 0.1; done'

postgres-shell:
	docker-compose up -d postgres
	docker exec -it $(VOLUME)_postgres_1 sh

migrations.all:
	docker-compose run django \
	  poetry run python manage.py migrate