data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "container_registry_token" {}

resource "aws_ecr_repository" "user-front" {
    name = "user-front"
    force_delete = true
}

resource "aws_ecr_repository_policy" "user-front" {
  repository = aws_ecr_repository.user-front.name
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
       "Principal": {
          "AWS": "*"
        },
        "Action": [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
      }
    ]
  }
  EOF
}
