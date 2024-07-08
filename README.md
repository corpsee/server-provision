Server deployment
=================

Requirements
------------

* Ansible v9+ (ansible-code v2.16+).

* Ubuntu 20.04+ (24.04 recommended) or Mint 20+ for desktop (21 recommended).

* Files:
    * `.vault_password` (Roles: webuser, php_censor, corpsee_site_symfony)
    * `inventories/group_vars/web_server/secret.yml` (Roles: webuser, php_censor, corpsee_site_symfony)
    * `inventories/group_vars/web_server_local/secret.yml` (Roles: webuser)
    * `inventories/production.yml` (Roles: corpsee_site_symfony)
    * `roles/webuser/files/<webuser_host>_github.pub` (`web_server_github.pub`, `web_server_local_github.pub`) (Roles: webuser)
    * `roles/webuser/files/<webuser_host>_github` (`web_server_github`, `web_server_local_github`) (Roles: webuser)
    * `roles/webuser/files/<webuser_host>_<webuser>.pub` (`web_server_web.pub`, `web_server_local_web.pub`) (Roles: webuser)
    * `roles/webuser/files/<webuser_host>_<webuser>` (`web_server_web`, `web_server_local_web`) (Roles: webuser)
    * `roles/corpsee_site_symfony/files/corpsee_site_symfony.sql.xz` (Roles: corpsee_site_symfony)
    * `roles/corpsee_site_symfony/files/public` (Roles: corpsee_site_symfony)
    * `corpsee-symfony.test.pem` (Roles: corpsee_site_symfony. For debug deploy/vagrant only)
    * `corpsee-symfony.test-key.pem` (Roles: corpsee_site_symfony. For debug deploy/vagrant only)
    * `roles/php_censor/files/artifacts` (`artifacts_test`) (Roles: php_censor)
    * `roles/php_censor/files/php_censor.sql.xz` (Roles: php_censor)
    * `roles/php_censor/files/php_censor_test.sql.xz` (Roles: php_censor)
    * `roles/php_censor/files/periodical.yml` (Roles: php_censor)
    * `roles/php_censor/files/periodical_test.yml` (Roles: php_censor)
    * `php-censor.test.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor.test-key.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor-test.test.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor-test.test-key.pem` (Roles: php_censor. For debug deploy/vagrant only)
    * `php-censor-site.test.pem` (Roles: php_censor_site. For debug deploy/vagrant only)
    * `php-censor-site.test-key.pem` (Roles: php_censor_site. For debug deploy/vagrant only)
    * `php-censor.server.pem` (Roles: php_censor. For local web server only)
    * `php-censor.server-key.pem` (Roles: php_censor. For local web server only)

* Files by roles:
    * webuser:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `inventories/group_vars/web_server_local/secret.yml`
        * `roles/webuser/files/<webuser_host>_github.pub` (`web_server_github.pub`, `web_server_local_github.pub`)
        * `roles/webuser/files/<webuser_host>_github` (`web_server_github`, `web_server_local_github`)
        * `roles/webuser/files/<webuser_host>_<webuser>.pub` (`web_server_web.pub`, `web_server_local_web.pub`)
        * `roles/webuser/files/<webuser_host>_<webuser>` (`web_server_web`, `web_server_local_web`)
    * corpsee_site_symfony:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `inventories/production.yml`
        * `roles/corpsee_site_symfony/files/corpsee_site_symfony.sql.xz`
        * `roles/corpsee_site_symfony/files/public`
        * `corpsee-symfony.test.pem` (For debug deploy/vagrant only)
        * `corpsee-symfony-key.pem` (For debug deploy/vagrant only)
    * php_censor:
        * `.vault_password`
        * `inventories/group_vars/web_server/secret.yml`
        * `roles/php_censor/files/php_censor.sql.xz`
        * `roles/php_censor/files/php_censor_test.sql.xz`
        * `roles/php_censor/files/periodical.yml`
        * `roles/php_censor/files/periodical_test.yml`
        * `roles/php_censor/files/artifacts` (`artifacts_test`)
        * `php-censor.test.pem` (For debug deploy/vagrant only)
        * `php-censor.test-key.pem` (For debug deploy/vagrant only)
        * `php-censor-test.test.pem` (For debug deploy/vagrant only)
        * `php-censor-test.test-key.pem` (For debug deploy/vagrant only)
        * `php-censor.server.pem` (For local web server only)
        * `php-censor.server-key.pem` (For local web server only)
    * php_censor_site:
        * `php-censor-site.test.pem` (For debug deploy/vagrant only)
        * `php-censor-site.test-key.pem` (For debug deploy/vagrant only)

Deploy
------

Debug deploy (Vagrant):

```bash
# server
vagrant box update && vagrant up --provision-with main

# corpsee-symfony.test
vagrant up --provision-with corpsee_site_symfony_init
RELEASE_VERSION="master" vagrant up --provision-with corpsee_site_symfony_release

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
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/web_server/main.yml -vv


# new.corpsee.com (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/corpsee_site_symfony_init.yml -vv
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/corpsee_site_symfony_release.yml --extra-vars="corpsee_site_symfony_version=master" -vv


# ci.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/php_censor_init.yml -vv
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/php_censor_release.yml --extra-vars="php_censor_version=master" -vv

# ci-test.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/php_censor_test_init.yml -vv
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/php_censor_test_release.yml --extra-vars="php_censor_version=master" -vv

# php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server/php_censor_site_init.yml -vv


# local server (by root user with password)
ansible-playbook -i ./inventories/production.yml -kK -u corpsee ./playbooks/web_server_local/main.yml -vv

# local ci.php-censor.info (by web user with ssh key)
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server_local/php_censor_init.yml -vv
ansible-playbook -i ./inventories/production.yml -K -u web ./playbooks/web_server_local/php_censor_release.yml --extra-vars="php_censor_version=master" -vv
```

Desktop:

```bash
ansible-playbook -i ./inventories/production.yml -c local -K ./playbooks/desktop/main.yml -vv
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
