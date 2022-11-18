resource "random_pet" "bucket_name" {
  prefix = format("demo-mkdocs-%s", var.env)
  length = 4
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = random_pet.bucket_name.id
  tags   = local.global_tags
}
