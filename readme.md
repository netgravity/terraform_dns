sed -n '/^#/!s/=.*//p' .env

Either use Makefile
or 
export $(sed -n '/^#/!s/=.*****//p' .env)
terraform apply 


## create s3 bucket for backend
sunny-tfstate
us-west-2

