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
