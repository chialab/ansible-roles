NTP
===

This role's duty is to set up [NTP](http://www.pool.ntp.org/) service.

Variables
---------

### `ntp_servers`
A list of NTP servers to be used for time syncronization. By default, only `pool.ntp.org` will be used, but you **should** set this value to a list of servers geographically close to your datacenter.

Example
-------

```yaml
---
ntp_servers:
  - 0.it.pool.ntp.org
  - 1.it.pool.ntp.org
  - 2.it.pool.ntp.org
  - 3.it.pool.ntp.org
```

Contributing
------------

Issues and pull requests are more than welcome!

This repo is a split of the main code that can be found [here](https://github.com/Chialab/ansible-roles).
Please, open pull requests against that repository instead.
