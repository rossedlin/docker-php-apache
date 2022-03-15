#!/usr/bin/env bash

docker compose down
docker build -t rossedlin/php-apache:8.1 .
#docker scan rossedlin/php-apache:8.1
