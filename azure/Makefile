units-tests:
	@echo "Testing Azure modules..."
	cd ./tests && go test -v  -timeout 90m

validate-and-plan:
	@echo "Running init..."
	terraform init -input=false
	@echo "Running validate..."
	terraform validate
	@echo "Running validate..."
	terraform plan -out tfapply-azure

apply:
	@echo "Running apply..."
	terraform apply tfapply-azure

plan-destroy:
	@echo "Running plan to destroy..."
	terraform plan -destroy -out tfdestroy-azure

destroy:
	@echo "Running apply to destroy..."
	terraform apply tfdestroy-azure

fmt:
	@terraform fmt -recursive