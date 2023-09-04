variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_cli_profile" {
  description = "aws profile"
  type        = string
}

variable "dynamodb" {
  description = "Terraform state lock DynamoDB"
  type        = string
}

variable "s3_bucket_logs" {
  description = "Terraform S3 state"
  type        = string
}

variable "s3_bucket_state" {
  description = "Terraform S3 state"
  type        = string
}

variable "s3_bucket_state_pipe" {
  description = "Terraform S3 state"
  type        = string
}

variable "repo_front" {
  description = "Github repository"
  type        = string
}

variable "branch" {
  description = "branch of the repository"
  type        = string
}

variable "account_id" {
  description = "account"
  type        = string
}

variable "pipeline_assume_role" {
  description = "Role"
  type        = string
}

