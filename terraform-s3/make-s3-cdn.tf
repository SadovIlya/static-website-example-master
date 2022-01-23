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
  access_key = "ASIAXWQUAD5H5LJHSYFJ"
  secret_key = "90tkUPvClj+2H4q/L/T7/CP0fXKHq62w+Exq3TNb"
  token = "IQoJb3JpZ2luX2VjED0aCXVzLWVhc3QtMSJIMEYCIQCVeANjmYJubLXf7JK5T2q9+cyDU3ILHeNIaEQHFeh7CgIhALWfOC4aaHO+MTn1nOvco2aJlKjTlq13bEykwG9iO1epKvUCCGYQABoMNTI5Mzk2NjcwMjg3IgxUKUD1DHPk+l1y76Mq0gIxahiEL1PXGzGo/DiyF49ayU7D4wx/d33UBZNadPKcS/GmcTMbRdTaw3dCGNVebX4HCWIIy+3oRk/Q4GQIwrd8fJszOJ6mzXCmiFnQHdFGslOw1aMT86rX52nVipNlva6c3t1FC0HUgJi0/NPvCDAKYuZ6boI9rGFzig7gqQNkHp1CX2vqPQ+FVvkKwZmIMXrtRkcBnGGgl/g6rBQb1BFYSCSJmaJcn7Zt7fsCz0Nj861n2hj/yERyspT/9oGBgSu2SNSx2jdsXrs1zpff7cY2zWbTKoMLki1KihbmKspnFcqq5zcdXe7ghRZN1fzNqVIpTnbyP0/MR524GuX1wLTMtSdAc6WW+NFoWVniMHkh2vBR498LjE032SNJDTM/rsR6UEn4NasYp5Ofy4qY/G7hwLUY8K3Vq8OvaHozcycbAMWkJKP6jt4A9KpsfVvHkD+VhzDDgrePBjqlASxLhe/rN7ahZjWR0c8ygGtPs0wET8tFGTeyhJcXucoFVZCstUQgV0VNRgmhZie7bECkbwJSi8AnP9wG27JTGiq3w6jTlB9MvWwG70iefyTZEkRtQL67gAKOy8whnYn8jrldkenOGP2rGULLPyLckh+T04OpazfsOJmu1HbzvD3pduoWQS1FwP5SLceUe2FeN68iMp76tZhc7Riw4JpqJKBZseno9w=="
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
