pagerduty_operations
=========

This role provides all the operations that are to be performed using the Pagerduty API.


Role Variables
--------------

Mandatory variable: `pagerduty_operation`

Depending on the value of `pagerduty_operation`, additional variables are required as follows:

| pagerduty_operation | Additional Required Variables |
|:-------------------:|:-----------------------------:|
|    get_incidents    |           service_id          |

Example Playbook
----------------


```yaml

---
- hosts: localhost
  roles:
  - {
      role: pagerduty_operations,
      pagerduty_operation: get_incidents,
      service_id: <your_pagerduty_service_id>
    }
```
