This is an automated way to [set up a static website on S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) 

*NOTE:* One thing to remeber is that aws [does not support `https` for static websites](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteEndpoints.html). If that is important to you (and it should be !) use other providers such as [Netlify](https://www.netlify.com/) for your static needs. (Actually you can if you use cloudfront with a custom CNAME and a custom cert.)

## Prerequisites

1. Create a IAM user with appropriate S3 perms to use for this. Do not use your root account. See [IAM best practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html).
2. Obtain the aws credentials i.e. aws_access_key and aws_secret_key and set the environment variables in your `.bash_profile` or something:
```
export TF_VAR_aws_access_key="your-access-key"
export TF_VAR_aws_secret_key="your-secret-key"
export TF_VAR_aws_region="us-west-2"

export AWS_ACCESS_KEY=$TF_VAR_aws_access_key
export AWS_SECRET_KEY=$TF_VAR_aws_secret_key
export AWS_REGION=$TF_VAR_aws_region
```
3. Ensure you have the aws command line tool configured
4. Ensure you have Terraform installed

## Steps

1. Initialize terraform
    
    `make tf-init`

2. Make the S3 bucket to house the website. Supply a namespace when prompted. Your assets will be placed in a bucket named: `{namespace}-demos3staticweb`

    `make tf-apply`

3. Copy over all static assets

    `make push-content NAMESPACE={your-namespace}`

4. Open an incognito wondow and you can view your website. See my example [here](http://jimmyislive-demos3staticweb.s3-website-us-west-2.amazonaws.com)

5. To tear everything down

    `make tf-destroy NAMESPACE={your-namespace}`


