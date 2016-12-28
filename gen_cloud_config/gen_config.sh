#!/bin/sh

DISCOVERY="$(curl -w '\n' 'https://discovery.etcd.io/new?size=3')";

echo "Generated new discovery url: ${DISCOVERY}";

awk -v token=$DISCOVERY '{gsub("{DISCOVERY_TOKEN}", token); print}' > ./cloud-config.yml < ./_cloud-config.yml;
