resource "aws_ssm_parameter" "s3_website_url" {
  name  = format("/s3/demo-mkdocs/%s/%s/url", var.env, var.region)
  type  = "String"
  value = aws_s3_bucket_website_configuration.s3_content_bucket_website_configuration.website_endpoint
  tags  = local.global_tags
}

resource "aws_ssm_parameter" "s3_website_id" {
  name  = format("/s3/demo-mkdocs/%s/%s/id", var.env, var.region)
  type  = "String"
  value = aws_s3_bucket_website_configuration.s3_content_bucket_website_configuration.id
  tags  = local.global_tags
}