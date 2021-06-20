Server deployment
=================

Requirements
------------

* Ansible v2.9+.

* Ubuntu 20.04+ or Mint 20+ (For desktop).

* Files:
    * `.vault_password` (Roles: webuser, php_censor, corpsee_site)
    * `inventories/group_vars/web_server/secret.yml` (Roles: webuser, php_censor, corpsee_site)
    * `inventories/production.yml` (Roles: corpsee_site)
    * `roles/webuser/files/<webuser_host>_github.pub` (`web_server_github.pub`, `web_server_local_github.pub`) (Roles: webuser)
    * `roles/webuser/files/<webuser_host>_github` (`web_server_github`, `web_server_local_github`) (Roles: webuser)
    * `roles/webuser/files/<webuser_host>_<webuser>.pub` (`web_server_web.pub`, `web_server_local_web.pub`) (Roles: webuser)
    * `roles/webuser/files/<webuser_host>_<webuser>` (`web_server_web`, `web_server_local_web`) (Roles: webuser)
    * `roles/corpsee_site/files/corpsee_site.sql` (Roles: corpsee_site)
    * `roles/corpsee_site/files/corpsee_site_test.sql` (Roles: corpsee_site)
    * `roles/corpsee_site/files/www` (`www_test`) (Roles: corpsee_site)
    * `corpsee.test.pem` (Roles: corpsee_site. For debug deploy/vagrant only)
    * `corpsee.test-key.pem` (Roles: corpsee_site. For debug deploy/vagrant only)
    * `corpsee-test.test.pem` (Roles: corpsee_site. For debug deploy/vagrant only)
    * `corpsee-test.test-key.pem` (Roles: corpsee_site. For debug deploy/vagrant only)
    * `roles/php_censor/files/artifacts` (`artifacts_test`) (Roles: php_censor)
    * `roles/php_censor/files/php_censor.sql` (Roles: php_censor)
    * `roles/php_censor/files/php_censor_test.sql` (Roles: php_censor)
    * `roles/php_censor/files/periodical.yml` (Roles: php_censor)
    * `roles/php_censor/files/periodical_test.yml` (Roles: php_censor)
    * `php-censor.test.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor.test-key.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor-test.test.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor-test.test-key.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor-site.test.pem` (Roles: php_censor_site. For debug deploy/vagrant only)
    * `php-censor-site.test-key.pem` (Roles: php_censor_site. For debug deploy/vagrant only)

* Files by roles:
    * webuser:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `roles/webuser/files/<webuser_host>_github.pub` (`web_server_github.pub`, `web_server_local_github.pub`)
        * `roles/webuser/files/<webuser_host>_github` (`web_server_github`, `web_server_local_github`)
        * `roles/webuser/files/<webuser_host>_<webuser>.pub` (`web_server_web.pub`, `web_server_local_web.pub`)
        * `roles/webuser/files/<webuser_host>_<webuser>` (`web_server_web`, `web_server_local_web`)
    * corpsee_site:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `inventories/production.yml`
        * `roles/corpsee_site/files/corpsee_site.sql`
        * `roles/corpsee_site/files/corpsee_site_test.sql`
        * `roles/corpsee_site/files/www`
        * `roles/corpsee_site/files/www_test`
        * `corpsee.test.pem` (For debug deploy/vagrant only)
        * `corpsee.test-key.pem` (For debug deploy/vagrant only)
        * `corpsee-test.test.pem` (For debug deploy/vagrant only)
        * `corpsee-test.test-key.pem` (For debug deploy/vagrant only)
    * php_censor:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `roles/php_censor/files/php_censor.sql`
        * `roles/php_censor/files/php_censor_test.sql`
        * `roles/php_censor/files/periodical.yml`
        * `roles/php_censor/files/periodical_test.yml`
        * `roles/php_censor/files/artifacts` (`artifacts_test`)
        * `php-censor.test.pem` (For debug deploy/vagrant only)
        * `php-censor.test-key.pem` (For debug deploy/vagrant only)
        * `php-censor-test.test.pem` (For debug deploy/vagrant only)
        * `php-censor-test.test-key.pem` (For debug deploy/vagrant only)
    * php_censor_site:
        * `php-censor-site.test.pem` (For debug deploy/vagrant only)
        * `php-censor-site.test-key.pem` (For debug deploy/vagrant only)

Deploy
------

Debug deploy (Vagrant):

```bash
# server
vagrant box update && vagrant up --provision-with main

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

# php-censor-site.test
vagrant up --provision-with php_censor_site_init
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


# server (by root user with password)
ansible-playbook -i ./inventories/production.yml -kK -u corpsee ./playbooks/web_server_local.yml -v
```

Desktop:

```bash
ansible-playbook -i ./inventories/production.yml -c local -K ./playbooks/desktop.yml -v
```

Workstation:

```bash
ansible-playbook -i ./inventories/production.yml -c local -K ./playbooks/workstation.yml -v
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

## License

Project is open source software licensed under the [GNU GPLv3](LICENSE).
