PHP5 CLI
========

This role's duty is to install [PHP5](https://php.net/) for command line (i.e. neither Apache server nor PHP5 Apache module are installed).

Furthermore, PHP's standard package manager _de facto_, [Composer](https://getcomposer.org/), will be installed.

Variables
---------

### `php5_composer`
Whether to install Composer. By default, this option is enabled.

### `php5_extensions`
List of PHP5 extensions to be installed. These packages are to be retrieved from APT. By default, only `curl`, `gd`, `intl`, `mcrypt`, `mysql`, `redis` and `xcache` are installed.

Example
-------

```yaml
---
php5_composer: yes

php5_extensions:
  - curl
  - gd
  - intl
  - mcrypt
  - mysql
  - redis
  - xcache
```
