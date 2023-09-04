

resource "aws_ecrpublic_repository" "user-front" {
  repository_name = "user-front-v2"

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
