Server deployment
=================

Deploy
------

Production deploy:

```bash
ansible-playbook -i ./inventories/vscale.ini -k -u root ./playbooks/web-server-install.yml
```

Desktop (Mint):

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
