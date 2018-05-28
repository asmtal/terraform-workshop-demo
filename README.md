# Terraform Quickstart
## Instalation
Prerequisites: 
- terraform installed
- An AWS profile on ~/.aws/credentials to define it on main.tf
- Change variables to suit your purposes such as "profile", "aws_id", "region", "ssh-key"...

On main.tf define your S3 bucket for the state and create a dynamoDB table for the lock
<pre>terraform init</pre>
## Validate
<pre>terraform plan</pre>
## Execute
<pre>terraform apply</pre>
