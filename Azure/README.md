# Graylog Azure Terraform Environment 

The environment setups up two servers, one for Elasticsearch and one for Graylog Traffic rule allows port 25 on both servers and port 9000 on Graylog. I do not recommending running this in a production environment. 

## TODO's

* Make the default password dynamic and random
* Comments in code
* Open ports to allow ingest of certain log events - Right now I manually add via the Azure Portal


# Instructions 
* Open main.tf and adjust the count for the Graylog Server.
* terraform init
* terraform plan
* terraform apply


## Remember to destroy
* terraform destroy

## Security Note

* This has a hard coded password. This setup is not intended to be used in production environments as it. Reset the password and secret. 
* Do not use this in production environment. You should review security policies and think about SSH security along with TLS security. 

