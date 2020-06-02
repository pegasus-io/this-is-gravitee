#!/bin/bash

set -e

# minimum is 262144
sudo sysctl -w vm.max_map_count=262144


echo '###################################################################' | sudo tee -a /etc/sysctl.conf
echo '# Cresh Kube Elasticsearch AWS AMI' | sudo tee -a /etc/sysctl.conf
echo "# [$(date)]" | sudo tee -a /etc/sysctl.conf
echo "vm.max_map_count=262144 " | sudo tee -a /etc/sysctl.conf
echo '' | sudo tee -a /etc/sysctl.conf

# sudo ulimit -n 65535
# https://www.elastic.co/guide/en/elasticsearch/reference/master/setting-system-settings.html#limits.conf
export ULIMIT_FOR_ELASTIC=65536


ls -allh /etc/security/limits.d/

echo "root            hard    core            ${ULIMIT_FOR_ELASTIC}" | sudo tee -a /etc/security/limits.conf
echo "root            hard    core            ${ULIMIT_FOR_ELASTIC}" | sudo tee -a /etc/security/limits.conf
echo "root   memlock    unlimited" | sudo tee -a /etc/security/limits.conf

echo "elasticsearch   soft    nofile          ${ULIMIT_FOR_ELASTIC}" | sudo tee -a /etc/security/limits.conf
echo "elasticsearch   hard    core            ${ULIMIT_FOR_ELASTIC}" | sudo tee -a /etc/security/limits.conf
echo "elasticsearch   memlock    unlimited" | sudo tee -a /etc/security/limits.conf

echo "ec2-user            hard    core            ${ULIMIT_FOR_ELASTIC}" | sudo tee -a /etc/security/limits.conf
echo "ec2-user            hard    core            ${ULIMIT_FOR_ELASTIC}" | sudo tee -a /etc/security/limits.conf
echo "ec2-user   memlock    unlimited" | sudo tee -a /etc/security/limits.conf


# Elastic Search user is in containers inside K8S cluster
