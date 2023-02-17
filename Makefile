postgres:
	docker run --name postgres_test -p 5555:5555 -e POSTGRES_USER=root_test -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it postgres_test createdb --username=root_test --owner=root_test simple_bank

dropdb:
	docker exec -it postgres_test dropdb  --username=root_test simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root_test:secret@localhost:5555/simple_bank?sslmode=disable" up

migratedown:
	migrate -path db/migration -database "postgresql://root_test:secret@localhost:5555/simple_bank?sslmode=disable" down

sqlc: ## run application
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown