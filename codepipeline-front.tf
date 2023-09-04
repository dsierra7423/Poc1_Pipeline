
resource "aws_codepipeline" "ecr_images" {
  name     = "pipeline-front"
  role_arn = aws_iam_role.ecr_images.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.deploy_logs.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github.arn
        FullRepositoryId     = var.repo_front
        BranchName           = var.branch
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["lint_output"]
      version          = "1"
      run_order        = "1"

      configuration = {
        ProjectName = aws_codebuild_project.ecr-images-front.name
        EnvironmentVariables = jsonencode([
          {
            name  = "AWS_DEFAULT_REGION"
            type  = "PLAINTEXT"
            value = var.aws_region
          },
          {
            name  = "AWS_ACCOUNT_ID"
            type  = "PLAINTEXT"
            value = var.account_id
          },
          {
            name  = "IMAGE_REPO_NAME"
            type  = "PLAINTEXT"
            value = aws_ecr_repository.user-front.name
          },
          {
            name  = "IMAGE_TAG"
            type  = "PLAINTEXT"
            value = "latest"
          }
        ])
      }
    }
  }
}