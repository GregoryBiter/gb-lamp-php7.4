.PHONY: help setup start ngrok up down logs clean

help: ## Показать эту справку
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Настроить права доступа к файлам (www)
	./.docker/scripts/fixPermissions.sh

start: ## Запустить проект (проверить .env, добавить хост, запустить Docker)
	./.docker/scripts/start.sh

ngrok: ## Запустить ngrok для туннелирования
	./.docker/scripts/start-ngrok.sh

up: ## Запустить Docker Compose в фоне
	docker compose up -d

down: ## Остановить Docker Compose
	docker compose down

logs: ## Показать логи Docker Compose
	docker compose logs -f

clean: ## Очистить контейнеры и образы
	docker compose down --volumes --remove-orphans
	docker system prune -f