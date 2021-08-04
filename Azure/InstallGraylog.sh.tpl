#!/bin/bash
sudo -u ubuntu bash -c : && RUNAS="sudo -u ubuntu"

sudo apt-get -y update && sudo apt-get upgrade -y
sudo apt-get -y install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen

#mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get -y update
sudo apt-get -y install -y mongodb-org

#Enable MongoDB
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl restart mongod.service
sudo systemctl --type=service --state=active | grep mongod



#GL
wget https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb
sudo dpkg -i graylog-4.0-repository_latest.deb
sudo apt-get -y update && sudo apt-get -y install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins


#Password= DoNotUseInProdOrCriticalData 
#e6f6a21488bbd328bba3af8171cc6b6df00f4f044cdab993c5102eb2fd556ce6
sudo sed -i 's/root_password_sha2 =/root_password_sha2 = e6f6a21488bbd328bba3af8171cc6b6df00f4f044cdab993c5102eb2fd556ce6/' /etc/graylog/server/server.conf

echo "http_bind_address = ${privateIP}:9000" | sudo tee -a /etc/graylog/server/server.conf
sudo sed -i 's/password_secret =/password_secret = qllwPZUM64sBbNswqRV6fsLdH2Wy3oCKrncNuYVDXKWLpc0PPWHLBxWkMMFaJxPqgcFEMLXTfwUQytXGJdh0xOcePtndy5Ay/' /etc/graylog/server/server.conf #TODO dynamically create these!!!
echo "elasticsearch_hosts = http://${elasticIP}:9200" | sudo tee -a /etc/graylog/server/server.conf
echo "http_external_uri = http://${publicIP}:9000/" | sudo tee -a /etc/graylog/server/server.conf
echo "elasticsearch_discovery_zen_ping_multicast_enabled = false" | sudo tee -a /etc/graylog/server/server.conf
echo  "rest_listen_uri = http://${publicIP}:9000/api/" | sudo tee -a /etc/graylog/server/server.conf

sudo ufw disable
sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service
