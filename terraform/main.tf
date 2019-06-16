provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "${var.namespace}-demos3staticweb"
  acl = "public-read"

  tags {
    Name = "DemoAWSS3StaticWeb"
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
