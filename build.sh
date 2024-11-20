#!/usr/bin/env bash

docker compose down
docker build -t rossedlin/php-apache:7.1 .
