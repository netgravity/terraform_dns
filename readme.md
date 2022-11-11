sed -n '/^#/!s/=.*//p' .env

Either use Makefile
or 
export $(sed -n '/^#/!s/=.*****//p' .env)
terraform apply 
