Server deployment
=================

Requirements
------------

* Ansible v2.0+ (v2.5).

Deploy
------

Debug deploy (Vagrant, Ubuntu Xenial 16.04):

```bash
vagrant up
```

Production deploy (Ubuntu Xenial 16.04):

```bash
ansible-playbook -i ./inventories/sprintbox.ini -k -u root ./playbooks/web-server.yml
```

Desktop (Mint 18.3, Ubuntu Xenial 16.04):

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
