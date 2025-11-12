#!/usr/bin/env bash

# Push to Docker Hub
docker push rossedlin/php-apache:8.4

# Tag the image
#docker tag rossedlin/php-apache:8.4 asia-southeast1-docker.pkg.dev/cryslo-test/minecraft/php-apache:8.4

#Push to GCloud
#docker push asia-southeast1-docker.pkg.dev/cryslo-test/minecraft/php-apache:8.4
