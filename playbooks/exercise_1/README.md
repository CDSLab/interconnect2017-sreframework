# Exercise 1

## Injecting a fault to enforce a [Failover](https://en.wikipedia.org/wiki/Failover) Scenario.

### Objective:

* Kill the App Server 1 Container, thereby forcing the NginX Load Balancer to switch to the App Server 2 Container; using the SRE Ansible framework.
* Ensure that an alert is thrown for the killed Docker Container (Real world scenarios would expect auto-resolution).

---

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
  pre_tasks:
    - name: Ensure that the app is running
      uri:
        url: http://localhost:80
  roles:
  - {
      role: docker_operations,
      docker_operation: stop_container,
      container_name: app1
    }
  post_tasks:
    - name: Test the App server failover
      uri:
        url: http://localhost:80
    - name: Verify the heartbeat of the killed container
      uri:
        url: http://localhost:8081/api/v1.3/docker/app1
        status_code: 500
        return_content: yes
      register: result
    - name: Throw alert if no heartbeat detected
      debug:
        msg: "Triggering the alert for the Container App1"
      when: "'failed to get Docker container' in result.content"

```

#### Explaining the code:

```shell
- hosts: localhost
```
Use the localhost (defined in the inventory file) to perform the Tasks and Roles provided in the playbook.

```shell
  pre_tasks:
    - name: Ensure that the app is running
      uri:
        url: http://localhost:80
```
Using the Ansible URI module, confirm whether the app is running fine before we head on for the Failover.

```shell
roles:
  - {
      role: docker_operations,
      docker_operation: stop_container,
      container_name: app1
    }
```
This is the core of our Fault Injection. Using the SRE framework role, use the Docker operations to stop the App1 container. Have a quick look at the SRE Framework structure [here](https://github.com/CDSLab/interconnect2017-sreframework/tree/master/sreFramework) and come back to our exercise.

```shell
  post_tasks:
    - name: Test the App server failover
      uri:
        url: http://localhost:80
    - name: Verify the heartbeat of the killed container
      uri:
        url: http://localhost:8081/api/v1.3/docker/app1
        status_code: 500
        return_content: yes
      register: result
    - name: Throw alert if no heartbeat detected
      debug:
        msg: "Triggering the alert for the Container App1"
      when: "'failed to get Docker container' in result.content"
```      
Post the fault injection, we verify whether the App is running again.
In the real world scenario, we would use the PagerDuty Role in the SRE Framework to verify whether a PagerDuty Alert has been triggered for this event. 


For the sake of our workshop, we would just verify whether the Container App1 is down using the cAdvosir REST API and display the message that an alert is triggered.

#### Lets run this playbook

```shell
cd ~/interconnect2017-sreframework/playbooks/
```
---

The file `ansible.cfg` defines the configurations for our Ansible playbooks.

```shell
[defaults]
inventory = ../inventory/hosts
roles_path = ../sreFramework/roles/
library = ../sreFramework/modules
stdout_callback = skippy
display_skipped_hosts = False
```

We'll learn more about roles and modules in our Exercise 2.

---

Run the `failover.yaml` playbook from this folder to have access to the Ansible configurations.

```shell
ansible-playbook exercise_1/failover.yaml
```

