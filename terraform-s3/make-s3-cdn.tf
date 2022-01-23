terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      
    }
  }
}
provider "aws" {
  region = "us-west-2"
}
resource "aws_s3_bucket" "bucket" {
  bucket = "sadov-lab-1"
  policy = file("policy.json")
  acl = "public-read"
    
  website {
      index_document = "index.html"
      error_document = "/error/index.html"
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "sadov-lab-1.s3.us-west-2.amazonaws.com"
    origin_id   = "website"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "website"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress = true

  }
    enabled             = true
    is_ipv6_enabled     = true
    #aliases = ["sadov"]
    default_root_object = "index.html"
    restrictions {
    geo_restriction {
      restriction_type = "none"
      }
  }
}