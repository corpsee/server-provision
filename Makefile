list:
	@sed -rn 's/^([a-zA-Z_-]+):.*?## (.*)$$/"\1" "\2"/p' < $(MAKEFILE_LIST) | xargs printf "%-20s%s\n"

encrypt-secrets: ## Encrypt secrets
	ansible-vault encrypt ./inventories/group_vars/web_server/secret.yml

decrypt-secrets: ## Decrypt secrets
	ansible-vault decrypt ./inventories/group_vars/web_server/secret.yml

yaml-lint: ## Yaml Linter
	pipx install yamllint
	yamllint -s .

ansible-lint: ## Ansible Linter
	pipx install ansible-lint
	ansible-lint -s

lint: yaml-lint ansible-lint ## Linters

.PHONY: list encrypt-secrets decrypt-secrets yaml-lint ansibl-lint
.DEFAULT_GOAL := list
