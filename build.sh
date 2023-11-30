#!/usr/bin/env bash

docker compose down
docker build -t rossedlin/php-apache:8.3 .
docker build -t ghcr.io/rossedlin/php-apache:8.3 .
