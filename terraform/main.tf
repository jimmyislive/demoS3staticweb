provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

#provider "aws" {
#  alias      = "acm_east_provider"
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
#  region     = "us-east-1"
#}

resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "${var.namespace}-demos3staticweb"
  acl    = "public-read"

  tags = {
    Name        = "DemoAWSS3StaticWeb"
    Environment = "production"
  }

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.namespace}-demos3staticweb/*"
      ]
    }
  ]
}
EOF


  website {
    index_document = "index.html"
  }
}


resource "aws_cloudfront_distribution" "demos3staticweb_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.static_website_bucket.bucket_regional_domain_name}"
    origin_id   = "S3-${var.namespace}-demos3staticweb"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.namespace}-demos3staticweb"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  tags = {
    Environment = "production"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
