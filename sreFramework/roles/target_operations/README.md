target_operations
=================

This role provides all the operations that are to be performed `ssh`ing into the target machine.

Role Variables
--------------

Mandatory variable: `target_operation`

Depending on the value of `target_operation`, additional variables are required as follows:

|     target_operation    | Additional Required Variables |
|:---------------------------------:|:---------------------------------:|
|  start_service_by_name            |          service_name             |
|   stop_service_by_name            |          service_name             |
| restart_service_by_name           |          service_name             |
|   kill_process_by_name            |          process_name             |

Example Playbooks
----------------
Start Service
```yaml

---
- hosts: webserver
  roles:
  - {
      role: target_operations,
      target_operation: start_service_by_name,
      service_name: httpd
    }
```

CPU Spike
```yaml

---
- hosts: dash
  roles:
    - {
        role: target_operations,
        target_operation: cpu_spike,
        cpu_pct: 70,
        seconds: 30
      }
```




