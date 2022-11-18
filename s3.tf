resource "random_pet" "bucket_name" {
  prefix = format("demo-mkdocs-%s", var.env)
  length = 4
}

resource "aws_s3_bucket" "s3_content_bucket" {
  bucket = random_pet.bucket_name.id
  tags   = local.global_tags

  force_destroy = true
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_content_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "s3_content_bucket_versioning" {
  bucket = aws_s3_bucket.s3_content_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_content_bucket_server_side_encryption" {
  bucket = aws_s3_bucket.s3_content_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_website_configuration" "s3_content_bucket_website_configuration" {
  bucket = aws_s3_bucket.s3_content_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }

  # dynamic "routing_rule" {
  #   for_each = try(flatten([var.advanced_config["routing_rules"]]), [])

  #   content {
  #     dynamic "condition" {
  #       for_each = [try([routing_rule.value.condition], [])]

  #       content {
  #         http_error_code_returned_equals = try(routing_rule.value.condition["http_error_code_returned_equals"], null)
  #         key_prefix_equals               = try(routing_rule.value.condition["key_prefix_equals"], null)
  #       }
  #     }

  #     redirect {
  #       host_name               = try(routing_rule.value.redirect["host_name"], null)
  #       http_redirect_code      = try(routing_rule.value.redirect["http_redirect_code"], null)
  #       protocol                = try(routing_rule.value.redirect["protocol"], null)
  #       replace_key_prefix_with = try(routing_rule.value.redirect["replace_key_prefix_with"], null)
  #       replace_key_with        = try(routing_rule.value.redirect["replace_key_with"], null)
  #     }
  #   }
  # }
}



resource "aws_s3_bucket_policy" "s3_content_bucket_policy" {
  bucket = aws_s3_bucket.s3_content_bucket.id
  policy = templatefile("${path.module}/templates/policy.tpl",
    {
      bucket-name = aws_s3_bucket.s3_content_bucket.id
    }
  )
}