# Terraform targets
tf-init:
	@cd terraform && terraform init
tf-apply:
	@cd terraform && terraform apply
tf-destroy:
	@aws s3 rm s3://$(NAMESPACE)-demos3staticweb/index.html
	@aws s3 rm s3://$(NAMESPACE)-demos3staticweb/cover.css
	@cd terraform && terraform destroy

# s3 targets
push-content:
	@aws s3 sync static/html s3://$(NAMESPACE)-demos3staticweb/ --content-type text/html
	@aws s3 sync static/css s3://$(NAMESPACE)-demos3staticweb/ --content-type text/css