#!/bin/bash

echo "Настройка прав доступа к файлам и папкам"
echo "$(pwd)/www"
sudo chown -R "$USER:$USER" "$(pwd)/www"
sudo chmod -R 777 "$(pwd)/www"