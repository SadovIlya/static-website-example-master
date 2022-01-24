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
  access_key = "ASIAXWQUAD5HZ6PZDDE6"
  secret_key = "CR8MafK2UD2bCRr50g2Og79iV+JiAavzmJnMprs0"
  token = "IQoJb3JpZ2luX2VjEEoaCXVzLWVhc3QtMSJIMEYCIQC26Lv/KvnAphlBHC5HvVCEQfzONsjPqQF5kqn5YLImtAIhAPJosc6N68ArClNo0eaoD/+2dB9/Xyx97Ihrajf8U4gPKvUCCHMQABoMNTI5Mzk2NjcwMjg3Igzg2pQOT3RvD12/Q5Yq0gLNvOuWBT1rGGWXnCqaQzFUo1N6xitLqi11BhBvBefZu+CMQoa2rIRlunVDNExtsyYZs7OtTwQZFgqKs7NCM/7WQ5Kvbw0zyLWnC92Ib5DBMd70qFohQTUy4vOSzDOjxusd+SjqSvqyv8LFC3rTFkgR4/U6lXuH1iPKY49fMDkQmxy2eJmcCxGifG08YK3IprXX0fBoV86Iw6AG2VC8uqP6osIUMuudjPJAFsduEG9pQ2YneiHdGbcPtDxpq3a68F6Nzo9IZ+nMsUJ1kRENgz1XtDqB+pKZdlcOxqhmMTCLGLwq4obgxTItexlplKgckyNxlBpHdCOC/Lhfc0G1EQmpdtVhOB4lE1ghbSAw/UfmF4aWb2NvnXMYKtN2Xr/KelObzs4c6JRhY1utYAzClh6GMVHbe2FCOBd/LWXow+xQAV080xWGlOZJjZ575+P8QvafVjCG6LmPBjqlAZ0543hnVfGpaBQrqXRWAzRt6YHJWQQ0aVNN92/8LtTLBtu2YKClxe2wNN7Dq9IhEjxV3WGptkr9pFkbCdh2E3mzWE+SUOoDN+v7PK6CGbmCOEDHiZ7JAmlLYn1uUI8PQ/0HZOzyudkAARLarJOFEAfeAUOJuLoqSsCA40uG7jVNJLgCXfjEXMMSpkzARKHEYSLnrjV9h5qrmE8XkFpwDLdDfne6/g=="
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
