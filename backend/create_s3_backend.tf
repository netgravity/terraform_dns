#provider "aws" {
#  region = "us-west-2"
#}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "sunny-tf" {
  bucket = var.aws_s3_backend_bucket

  tags = {
      Name        = "sunny-tf"
      Environment = "Dev"
    }

  lifecycle {
    #prevent_destroy = true
    prevent_destroy = false
   }
}

resource "aws_dynamodb_table" "tform-locks" {
  #provider = aws.us-east-2

  hash_key         = "LockID"
  name             = "terraform-state-locking"
 # stream_enabled   = true
 # stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.sunny-tf.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.sunny-tf.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.sunny-tf.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.sunny-tf.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
