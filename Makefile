list:
	@sed -rn 's/^([a-zA-Z_-]+):.*?## (.*)$$/"\1" "\2"/p' < $(MAKEFILE_LIST) | xargs printf "%-20s%s\n"

encrypt-secrets: ## Encrypt secrets
	ansible-vault encrypt ./inventories/group_vars/web_server/secret.yml

decrypt-secrets: ## Decrypt secrets
	ansible-vault decrypt ./inventories/group_vars/web_server/secret.yml

.PHONY: list encrypt-secrets decrypt-secrets
.DEFAULT_GOAL := list
