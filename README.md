Server deployment
=================

Requirements
------------

* Ansible v2.5+.
* Ubuntu 16.04 (14.04, 18.04) (image for server) and Mint 18.3 (19) (for desktop).

Add files:

* inventories/group_vars/web-server/secret.yml
* inventories/production.yml
* .vault_password
* ~/.ssh/github.pub
* ~/.ssh/github
* roles/corpsee_site/files/corpsee_site.sql
* roles/corpsee_site/files/corpsee_site_test.sql
* roles/corpsee_site/files/www
* roles/php_censor/files/php_censor.sql
* roles/php_censor/files/php_censor_test.sql

Deploy
------

Debug deploy (Vagrant):

```bash
# server
vagrant up [--provision-with main]

# corpsee.test
vagrant up --provision-with corpsee_site_init
RELEASE_VERSION="master" vagrant up --provision-with corpsee_site_release

# corpsee-test.test
vagrant up --provision-with corpsee_site_test_init
RELEASE_VERSION="master" vagrant up --provision-with corpsee_site_test_release

# php-censor.test
vagrant up --provision-with php_censor_init
RELEASE_VERSION="master" vagrant up --provision-with php_censor_release

# php-censor-test.test
vagrant up --provision-with php_censor_test_init
RELEASE_VERSION="master" vagrant up --provision-with php_censor_test_release
```

Production deploy:

```bash
# server
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/web_server.yml

# corpsee.com
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/corpsee_site_init.yml
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/corpsee_site_release.yml --extra-vars="corpsee_site_version=master"

# test.corpsee.com
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/corpsee_site_test_init.yml
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/corpsee_site_test_release.yml --extra-vars="corpsee_site_version=master"

# ci.php-censor.info
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/php_censor_init.yml
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/php_censor_release.yml --extra-vars="php_censor_version=master"

# ci-test.php-censor.info
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/php_censor_test_init.yml
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/php_censor_test_release.yml --extra-vars="php_censor_version=master"
```

Desktop:

```bash
ansible-playbook -i ./inventories/desktop.yml -c local -K ./playbooks/desktop.yml
```

Secret data
-----------

```bash
ansible-vault encrypt ./inventories/group_vars/web-server/secret.yml
```

```bash
ansible-vault decrypt ./inventories/group_vars/web-server/secret.yml
```

Facts
-----

```bash
ansible -m setup localhost
```
