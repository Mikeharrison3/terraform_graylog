#!/bin/bash

sudo apt-get -y update && sudo apt-get upgrade -y
sudo apt-get -y install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen
sudo wget -q https://artifacts.elastic.co/GPG-KEY-elasticsearch -O myKey
sudo apt-key add myKey
echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get -y install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen
sudo apt-get -y update && sudo apt-get -y install elasticsearch-oss

echo "cluster.name: graylog" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "action.auto_create_index: false" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "network: " | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo " host: 0.0.0.0" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "http:" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "  port: 9200" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "discovery.type: single-node" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
#change heapsize in jvm.options
sudo sed -i 's/Xms1g/Xms1g/' /etc/elasticsearch/jvm.options
sudo sed -i 's/Xmx1g/Xmx1g/' /etc/elasticsearch/jvm.options
sudo sed -i 's/TimeoutStartSec=75/TimeoutStartSec=500/' /usr/lib/systemd/system/elasticsearch.service
sudo chown -R elasticsearch:elasticsearch /etc/default/elasticsearch
sudo chown -R elasticsearch:elasticsearch /etc/elasticsearch
sudo chown -R elasticsearch:elasticsearch /var/lib/elasticsearch

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl restart elasticsearch.service