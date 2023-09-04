resource "aws_s3_bucket" "deploy_logs" {
  bucket        = var.s3_bucket_logs
}
