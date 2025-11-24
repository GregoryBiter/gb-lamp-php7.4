#!/bin/bash

# Если нет docker-compose.yml, скопировать из шаблона php7.4
if [ ! -f "docker-compose.yml" ]; then
    echo "Файл docker-compose.yml не найден. Копируем из шаблона php7.4..."
    cp ".docker/templates/php7.4/docker-compose.yml" "docker-compose.yml"
    echo "✓ Скопирован docker-compose.yml для php7.4"
fi

# Проверяем наличие файла .env
if [ ! -f ".env" ]; then
    echo "Файл .env не найден. Копируем из .env.example..."
    cp .env.example .env
    echo "✓ Файл .env создан."
fi

# Запускаем docker compose up
echo "Запускаем docker compose up..."
docker compose up -d