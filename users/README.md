Users
=====

This role's duty is to set up users and groups.

Variables
---------

### `users_groups`
A list of groups to be created.

### `users`
A dictionary of users to be created, where:

- the key represents the username of the user to be created
- a **required** key `password` is the password to be set on user creation — it will not override current user password
- an *optional* key `group` is the primary group of the user
- an *optional* key `groups` is a list of additional groups
- an *optional* key `ssh_keys` is a list of public keys to add in `authorized_keys` for SSH access
- an *optional* key `ssh_keys_url` is an URL to which retrieve public keys to add in `authorized_keys` for SSH access
- an *optional* key `generate_ssh_key` is a boolean value to decide if a private/public key pair should be generated for the user
- an *optional* key `ssh_key_public` is a public key to be written in `$HOME/.ssh/id_rsa.pub`
- an *optional* key `ssh_key_private` is a private key to be written in `$HOME/.ssh/id_rsa`
- an *optional* key `ps1` is the PS1 string to set for the user

Example
-------

```yaml
---
users_groups:
  - sysadmins
  - othergroup
users:
  fquffio:
    password: $6$rounds=656000$6xPefyB0D3dQacsd$/bC.gnd6M.WThGD7dlHrZMSfV3fETYAywhYRqMc09qLSArqKS.EpvVtKaxyI15GSp9AWzuBSNRoLx7vsp5jiq/
    ssh_keys_url: https://github.com/fquffio.keys
    generate_ssh_key: yes
    group: sysadmins
    groups:
      - othergroup
      - sudo
```

Contributing
------------

Issues and pull requests are more than welcome!

This repo is a split of the main code that can be found [here](https://github.com/Chialab/ansible-roles).
Please, open pull requests against that repository instead.
