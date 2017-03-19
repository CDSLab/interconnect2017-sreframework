# Exercise 1

## Injecting a fault to enforce a [Failover](https://en.wikipedia.org/wiki/Failover) Scenario.

### Objective:

* Kill the App Server 1 Container, thereby forcing the NginX Load Balancer to switch to the App Server 2 Container; using the SRE Ansible framework.
* Ensure that an alert is thrown for the killed Docker Container (Real world scenarios would expect auto-resolution).

#### Lets head on to writing some code:

```shell
cd ~/interconnect2017-sreframework/playbooks/exercise_1/
vim failover.yaml
```

**Indentation** matters in a .yaml file. So let's maintain a convention of 2 spaces for indentation.

Type in the following code into your `failover.yaml`

```shell
---
- hosts: localhost
  tasks:
    - name: Ensure that the App is running
      uri:
        url: http://localhost:80
  roles:
  - {
      role: docker_operations,
      docker_operation: stop_container,
      container_name: app1
    }
  tasks:
    - name: Test the App server Failover
      uri:
        url: http://localhost:80
    - name: Verify the alert for killed server
      uri:
        url: http://localhost:8081/api/v1.3/docker/app1
        register: result
        fail: msg="Failed as the Server 1 is still active"
        when: result.status == 200

```
