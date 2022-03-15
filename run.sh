#!/usr/bin/env bash

docker run -v $PWD/:/var/www rossedlin/php-apache:8.1 composer create-project laravel/laravel example-app
