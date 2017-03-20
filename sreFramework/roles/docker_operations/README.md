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
| pull_image  | `image_name` [ repo/image:tag ] |
| remove_image | `image_name` |

Example Playbooks
----------------
Start Container:
```yaml

---
- hosts: host-machine
  roles:
  - {
      role: docker_operations,
      docker_operation: start_container,
      container_name: ubuntu,
      image_name: ubuntu,
      interactive: yes

    }
```

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

Pull an image:
```yaml
---
- hosts: host-machine
  roles:
  - {
      role: docker_operations,
      docker_operation: pull_image,
      image_name: na.cumulusrepo.com/bi_basic/hello-world:latest
    }

```

Remove an image:
```yaml
---
- hosts: host-machine
  roles:
  - {
      role: docker_operations,
      docker_operation: remove_image,
      image_name: na.cumulusrepo.com/bi_basic/hello-world:latest
    }

```


