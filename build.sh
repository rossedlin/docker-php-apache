#!/usr/bin/env bash

docker compose down --volumes --remove-orphans
docker build -t rossedlin/php-apache:8.4 .
