terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "AWS_named_profile" {
  description = "named profile specified for AWS CLI config. See ~/.aws/credentials"
  type        = string
  default     = "default"
}

provider "aws" {
  profile = "digital_booking_g8"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "g8-terraform-backend"
  force_destroy = true
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "g8-terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
