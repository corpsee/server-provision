Server deployment
=================

Requirements
------------

* Ansible v2.9+.

* Ubuntu 20.04 or Mint 20 (For desktop).

* Files:
    * `.vault_password` (roles: webuser, php_censor, corpsee_site)
    * `inventories/group_vars/web_server/secret.yml` (roles: webuser, php_censor, corpsee_site)
    * `inventories/production.yml` (roles: corpsee_site)
    * `roles/webuser/files/web_server_github.pub` (roles: webuser)
    * `roles/webuser/files/web_server_github` (roles: webuser)
    * `roles/webuser/files/web_server_<webuser>.pub` (`web_server_web.pub`) (roles: webuser)
    * `roles/webuser/files/web_server_<webuser>` (`web_server_web`) (roles: webuser)
    * `roles/corpsee_site/files/corpsee_site.sql` (roles: corpsee_site)
    * `roles/corpsee_site/files/corpsee_site_test.sql` (roles: corpsee_site)
    * `roles/corpsee_site/files/www` (`www_test`) (roles: corpsee_site)
    * `roles/php_censor/files/artifacts` (`artifacts_test`) (roles: php_censor)
    * `roles/php_censor/files/php_censor.sql` (roles: php_censor)
    * `roles/php_censor/files/php_censor_test.sql` (roles: php_censor)
    * `roles/php_censor/files/periodical.yml` (roles: php_censor)
    * `roles/php_censor/files/periodical_test.yml` (roles: php_censor)

* Files by roles:
    * webuser:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `roles/webuser/files/web_server_github.pub`
        * `roles/webuser/files/web_server_github`
        * `roles/webuser/files/web_server_<webuser>.pub` (`web_server_web.pub`)
        * `roles/webuser/files/web_server_<webuser>` (`web_server_web`)
    * corpsee_site:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `inventories/production.yml`
        * `roles/corpsee_site/files/corpsee_site.sql`
        * `roles/corpsee_site/files/corpsee_site_test.sql`
        * `roles/corpsee_site/files/www` (`www_test`)
    * php_censor:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `roles/php_censor/files/php_censor.sql`
        * `roles/php_censor/files/php_censor_test.sql`
        * `roles/php_censor/files/periodical.yml`
        * `roles/php_censor/files/periodical_test.yml`
        * `roles/php_censor/files/artifacts` (`artifacts_test`)

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
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/web_server.yml -v

# corpsee.com (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_init.yml -v
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_release.yml --extra-vars="corpsee_site_version=master" -v

# test.corpsee.com (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_test_init.yml -v
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/corpsee_site_test_release.yml --extra-vars="corpsee_site_version=master" -v

# ci.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_init.yml -v
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_release.yml --extra-vars="php_censor_version=master" -v

# ci-test.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_test_init.yml -v
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/php_censor_test_release.yml --extra-vars="php_censor_version=master" -v
```

Desktop:

```bash
ansible-playbook -i ./inventories/desktop.yml -c local -K ./playbooks/desktop.yml -v
```

Workstation:

```bash
ansible-playbook -i ./inventories/workstation.yml -c local -K ./playbooks/workstation.yml -v
```

Secret data
-----------

```bash
ansible-vault encrypt ./inventories/group_vars/web_server/secret.yml
```

```bash
ansible-vault decrypt ./inventories/group_vars/web_server/secret.yml
```

Facts
-----

```bash
ansible -m setup localhost
```
