resource "aws_s3_bucket" "logging_bucket" {
  bucket = "my-emr-logging-bucket"
  
 
  versioning {
    enabled = true
  }
}