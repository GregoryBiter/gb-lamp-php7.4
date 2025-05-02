#!/bin/bash

# Переходим в корень проекта перед запуском
cd "$(dirname "$0")"

# Проверка аргументов
if [ "$1" = "up" ]; then
    echo "Запуск контейнеров..."
    docker-compose up -d
elif [ "$1" = "down" ]; then
    echo "Остановка контейнеров..."
    docker-compose down
elif [ "$1" = "restart" ]; then
    echo "Перезапуск контейнеров..."
    docker-compose down
    docker-compose up -d
elif [ "$1" = "logs" ]; then
    echo "Вывод логов..."
    docker-compose logs -f
elif [ "$1" = "build" ]; then
    echo "Сборка контейнеров..."
    docker-compose build
elif [ "$1" = "rebuild" ]; then
    echo "Пересборка и запуск контейнеров..."
    docker-compose down
    docker-compose build
    docker-compose up -d
else
    echo "Использование: $0 [up|down|restart|logs|build|rebuild]"
    exit 1
fi