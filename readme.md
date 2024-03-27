sed -n '/^#/!s/=.*//p' .env

Either use Makefile
or 
export $(sed -n '/^#/!s/=.*****//p' .env)
terraform apply 


## create s3 bucket for backend
sunny-tfstate
us-west-2


## For ever terraform project create backend
create a s3 backend for all terraform projects to store the state file and use state locking to lock tfstate being
changed when apply command is in use by someone.
navigate to backend dir and run the terraform apply .
Also have commented the prevent_destroy(false now) but in prod use true to protect the s3 bucket in turn protecting the tfstate file.

## Modify the main.tf file to include backend 
 Example
```
terraform {
  backend "s3" {
   # bucket = "${var.aws_s3_backend_bucket}"
    bucket = "sunny-tf"
    key    = "terraform/dev/terraform.tfstate"
    #region = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}
```
# Use tfstate for every project

Think (yet to test) no need for backend dir once we have created for the first time, unless we need to chnage s3 bucket name.permissions or dynamo db stuff.
Would only need to change the key name in main.tf file `key = "terraform/dev/terraform.tfstate"` , change the key to unique project name for example
so that we have a tfstate file for every project

## DNS
registered a domain kiwithon.com in cloudflare . once domian is created to create `red.kiwithon.com` in aws route 53, we can run the terraform apply cmmand mentioned above.This creates a zone in route53 with red.... and the output of the nameserver entries are then used to create dns NS records in cloudflare dns records section.
terraform will create new red.kiwithon.com records in cloudflare oitning ns records to the aws nameservers which were outputted by terraform script when route 53 zone was created.

