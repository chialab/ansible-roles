Common
======

This role's duty is to perform common operations, such as installing locales and setting up MoTD.

Variables
---------

### `locales`
A list of locales to be installed. By default, only `en_US` and `en_US.UTF-8` will be installed.

### `motd`
**M**essage **o**f **T**he **D**ay. By default, this is empty, thus no MoTD is set.

Example
-------

```yaml
---
locales:
  - de_DE
  - de_DE.UTF-8
  - en_US
  - en_US.UTF-8
  - fr_FR
  - fr_FR.UTF-8
  - it_IT
  - it_IT.UTF-8
motd: Hey there!
```

Contributing
------------

Issues and pull requests are more than welcome!

This repo is a split of the main code that can be found [here](https://github.com/Chialab/ansible-roles).
Please, open pull requests against that repository instead.
