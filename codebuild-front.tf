resource "aws_codebuild_project" "ecr-images-front" {
  name           = "build-images-front"
  description    = ""
  build_timeout  = "60"
  queued_timeout = "480"
  service_role   = aws_iam_role.role.arn

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.repo_front}"
    git_clone_depth = 1
    buildspec       = "buildECR.yaml"

    git_submodules_config {
      fetch_submodules = false
    }
  }

  source_version = "main"
  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"  
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.deploy_logs.bucket
  }

  logs_config {
    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.deploy_logs.id}/build-log"
    }
  }
}