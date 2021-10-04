#!/usr/bin/env bash

# Push to Docker Hub
docker push rossedlin/php-apache:7.4

# Tag the image
#docker tag rossedlin/php-apache:7.4 asia-southeast1-docker.pkg.dev/cryslo-test/minecraft/php-apache:7.4

#Push to GCloud
#docker push asia-southeast1-docker.pkg.dev/cryslo-test/minecraft/php-apache:7.4
