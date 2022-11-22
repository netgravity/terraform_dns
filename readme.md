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
