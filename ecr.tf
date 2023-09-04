

resource "aws_ecrpublic_repository" "user-front" {
  repository_name = "user-front-v1"

  catalog_data {
    about_text        = "About Text"
    architectures     = ["X64"]
    description       = "Description"
    operating_systems = ["Linux"]
    usage_text        = "Usage Text"
  }

  tags = {
    env = "production"
  }
}

resource "aws_ecr_repository_policy" "user-front" {
  repository = aws_ecrpublic_repository.user-front.repository_name
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
