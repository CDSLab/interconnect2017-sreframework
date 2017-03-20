docker_operations
=================

This role provides all the operations that are to be performed on docker containers and images.

Role Variables
--------------

Mandatory variable: `docker_operation`

Depending on the value of `docker_operation`, additional variables are required as follows:

| docker_operation |        Additional Required Variables        |
|:----------------:|:-------------------------------------------:|
|  stop_container  |               `container_name`              |


Example Playbooks
----------------

Stop a container:
```yaml
---
- hosts: host-machine
  roles:
  - {
      role: docker_operations,
      docker_operation: stop_container,
      container_name: ubuntu
    }

```

