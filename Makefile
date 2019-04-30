all: build

build:
	make -C ./providence $@
	make -C ./pawtucket2 $@

upd:
	docker-compose up -d

down:
	docker-compose down


