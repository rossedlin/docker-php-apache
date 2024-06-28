#!/usr/bin/env bash

docker compose down
docker build -t rossedlin/php-apache:7.4 .
docker build -t ghcr.io/rossedlin/php-apache:7.4 .
