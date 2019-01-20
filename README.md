Server deployment
=================

Requirements
------------

* Ansible v2.5+.

* Ubuntu 18.04 (14.04, 16.04) (Image for server) and Mint 19.1 - bionic (19.0 - bionic, 18.3 - xenial) (For desktop).

* Files:
    * `.vault_password` (roles: webuser, php_censor, corpsee_site)
    * `inventories/group_vars/web-server/secret.yml` (roles: webuser, php_censor, corpsee_site)
    * `inventories/production.yml` (roles: corpsee_site)
    * `~/.ssh/github.pub` (roles: php_censor, corpsee_site)
    * `~/.ssh/github` (roles: php_censor, corpsee_site)
    * `~/.ssh/ansible_web_server_<webuser>.pub` (`ansible_web_server_web.pub`) (roles: webuser)
    * `~/.ssh/ansible_web_server_<webuser>` (`ansible_web_server_web`) (roles: webuser)
    * `roles/corpsee_site/files/corpsee_site.sql` (roles: corpsee_site)
    * `roles/corpsee_site/files/corpsee_site_test.sql` (roles: corpsee_site)
    * `roles/corpsee_site/files/www` (roles: corpsee_site)
    * `roles/php_censor/files/php_censor.sql` (roles: php_censor)
    * `roles/php_censor/files/php_censor_test.sql` (roles: php_censor)
    * `roles/php_censor/files/periodical.yml` (roles: php_censor)
    * `roles/php_censor_release/files/periodical.yml` (roles: php_censor_release)

* Files by roles:
    * webuser:
        * `.vault_password`
        * `inventories/group_vars/web-server/secret.yml`
        * `~/.ssh/ansible_web_server_<webuser>.pub` (`ansible_web_server_web.pub`)
        * `~/.ssh/ansible_web_server_<webuser>` (`ansible_web_server_web`)
    * corpsee_site:
        * `.vault_password`
        * `inventories/group_vars/web-server/secret.yml`
        * `inventories/production.yml`
        * `~/.ssh/github.pub`
        * `~/.ssh/github`
        * `roles/corpsee_site/files/corpsee_site.sql`
        * `roles/corpsee_site/files/corpsee_site_test.sql`
        * `roles/corpsee_site/files/www`
    * php_censor:
        * `.vault_password`
        * `inventories/group_vars/web-server/secret.yml`
        * `~/.ssh/github.pub`
        * `~/.ssh/github`
        * `roles/php_censor/files/php_censor.sql`
        * `roles/php_censor/files/php_censor_test.sql`
        * `roles/php_censor/files/periodical.yml`
    * php_censor_release:
        * `roles/php_censor_release/files/periodical.yml`

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
# server (by root user with password)
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/web_server.yml

# corpsee.com (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_init.yml
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_release.yml --extra-vars="corpsee_site_version=master"

# test.corpsee.com (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_test_init.yml
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_test_release.yml --extra-vars="corpsee_site_version=master"

# ci.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_init.yml
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_release.yml --extra-vars="php_censor_version=master"

# ci-test.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_test_init.yml
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_test_release.yml --extra-vars="php_censor_version=master"
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
