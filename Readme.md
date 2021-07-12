# Graylog Terraform Environment 

The environment setups up two subnets. One private that has a NAT interface and hosts the ElasticSearch database. The public database hosts an elastic IP for Graylog and allows ports 9000 in. Connects to ElasticSearch in the private domain.

## TODO's

*Fix the InstallGraylog.sh script. There were some changes to the Graylog server.conf file that I had to make to get Graylog to work. I have those in the TODO's. Need to update the script.
*Comments
*Open ports to allow ingest of certain services


# Instructions 

* terraform init
* terraform plan
* terraform apply
    * At this time - updat the graylogserver.conf to have the correct host/uri bindings. Restart Graylog-server after update.


## Remember to destroy
* terraform destroy
