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
  access_key = "ASIAXWQUAD5HSQCZAHMQ"
  secret_key = "ZcqaxMXCto15r4WSs2qIvHHYmCoNX28UOVbapbm2"
  token = "IQoJb3JpZ2luX2VjEEsaCXVzLWVhc3QtMSJIMEYCIQDH3BihZZIvCRQRRU8J5JTrA+Qq2o3R3qz6UJMkA6Gv1wIhAJrE4SK9V2qtSmsPDyTxjDL+KJEuNs75UTPEIeqAO8/MKvUCCHQQABoMNTI5Mzk2NjcwMjg3IgxQSyN3/wOhXhIdPx0q0gJcv5Jv4oM/Pei4ELGn+xMpQvnR6rNujqBCBBDNLD5BiBSVuL139nnTP0tG7yvxItnjbg4XKAIOuLmp7WX/KWI/zyeMvxtmiK88mW2aRgYf54qG0sNz6HemFHbGZv5MVKsRfIKl49nmc9mQiJCi+M3gXLfs3PbBZHPxSZVd+uh/VIHk/hZixj5hhm/4SiePD9KlzxjIYv0eWjaubBe6C7P2QJQbuiNAtt77UlziAitFtqE6rjTdeN9dC5+MOGAutulz/qqZgyEPGPQsfyp3Ot/MQeHdx1TwwrCWuIVNif2zvxYkhNPtZovzoOJ4Bj3fpbctEenJZQkbWOkwBiX3OLPDeqVOAC8WRvkM3jMzMN+XhIQ8wTCcNo2ogZw4rr2GxwwzwLo3NaN8WTkIZnplUkDUl/31Nke1h9L9y528/u04WKvqaqdLhkrPVW+0uadbhchCzzC6iLqPBjqlAZlhlztYNIWMv/CEssvkcGjbLPuDfH76Uo9ASGd1D4M88J2WriRMSk6fCiTt0FA1mM/0zCnmzFlvUkSccYDmVWNK8ve5mJKXNiQk/Elr/sob5f5lqrEzDxbZdiMJQx4Cz4DcbMEosgRQFLhgc0tg2Cg4nyiqhfNDtIfGNELzF3W5xTaIXE5hpY15mVqKeZ0CGFkk/rr58x9W4V4NNThq9UAb5WUTiA=="
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
