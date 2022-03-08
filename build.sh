#!/usr/bin/env bash

docker compose down
docker build -t rossedlin/php-apache:8.0 .
