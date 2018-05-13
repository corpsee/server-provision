Server deployment
=================

Requirements
------------

Tested on:

* Ansible v2.5.
* Ubuntu 16.04 xenial (image for server) and Mint 18.3 (for desktop).

Deploy
------

Debug deploy (Vagrant):

```bash
vagrant up
```

Production deploy:

```bash
ansible-playbook -i ./inventories/production.ini -k -u root ./playbooks/web_server.yml
```

Desktop:

```bash
ansible-playbook -i ./inventories/desktop.ini -c local -K ./playbooks/desktop.yml
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
