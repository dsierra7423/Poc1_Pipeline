resource "aws_s3_bucket" "deploy_logs" {
  bucket        = var.s3_bucket_logs
}

resource "aws_s3_bucket" "state_bucket" {
  bucket        = var.s3_bucket_state_pipe
}
