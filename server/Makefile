include ./config/.env

MIGRATION_DIR=migrations

DB_DSN=postgresql://$(PG_USR):$(PG_PWD)@$(PG_HOST):5432/eggsan?sslmode=disable


.PHONY: run
run:
	@echo "Running the application..."
	go run main.go
.PHONY: migrate-up
migrate-up:
	@echo "Applying migrations..."
	goose -dir $(MIGRATION_DIR) postgres "$(DB_DSN)" up

.PHONY: migrate-down
migrate-down:
	@echo "Reverting the last migration..."
	goose -dir $(MIGRATION_DIR) postgres "$(DB_DSN)" down

.PHONY: migrate-create
migrate-create:
	@echo "Creating new migrate file..."
	goose -dir $(MIGRATION_DIR) postgres "$(DB_DSN)" create $(name) sql