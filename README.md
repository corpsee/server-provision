Server deployment
=================

Requirements
------------

* Ansible v2.5+.
* Ubuntu 16.04 (14.04, 18.04) (image for server) and Mint 18.3 (for desktop).

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
vagrant up
```

Production deploy:

```bash
ansible-playbook -i ./inventories/production.yml -k -u root ./playbooks/web_server.yml
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
