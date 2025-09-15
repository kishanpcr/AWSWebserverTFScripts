# s3.tf - S3 bucket resources

# Random ID for unique bucket naming
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 Bucket for static assets
resource "aws_s3_bucket" "static_assets" {
  bucket = "${var.environment}-static-assets-${random_id.bucket_suffix.hex}"

  tags = merge(local.common_tags, {
    Name        = "${var.environment}-static-assets"
    Purpose     = "Static web assets"
    ContentType = "web-assets"
  })
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "static_assets_versioning" {
  bucket = aws_s3_bucket.static_assets.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "static_assets_encryption" {
  bucket = aws_s3_bucket.static_assets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "static_assets_pab" {
  bucket = aws_s3_bucket.static_assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}