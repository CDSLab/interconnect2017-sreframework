# Exercise 1

## Injecting a fault to enforce a [Failover](https://en.wikipedia.org/wiki/Failover) Scenario.

### Objective:

* Kill the App Server 1 Container, thereby forcing the NginX Load Balancer to switch to the App Server 2 Container; using the SRE Ansible framework.
* Ensure that an alert is thrown for the killed Docker Container (Real world scenarios would expect auto-resolution).

---

#### If you are absolutely new to Ansible, checking [how ansible works](https://www.ansible.com/how-ansible-works) might help. 

#### Lets head on to writing some code:

```shell
cd ~/interconnect2017-sreframework/playbooks/exercise_1/
vim failover.yaml
```

**Indentation** matters in a .yaml file. So let's maintain a convention of 2 spaces for indentation.

#### Lets start coding our playbook:

Use the localhost (defined in the inventory file) to perform the Tasks and Roles provided in the playbook.

```yaml
- hosts: localhost
```

Using the Ansible URI module, confirm whether the app is running fine before we head on for the Failover.

```yaml
  pre_tasks:
    - name: Ensure that the app is running
      uri:
        url: http://localhost:80
```

Using the SRE framework role, use the Docker operations to stop the App1 container. This is the core of our Fault Injection.

Have a quick look at the SRE Framework structure [here](https://github.com/CDSLab/interconnect2017-sreframework/tree/master/sreFramework) and come back to our exercise.

```yaml
roles:
  - {
      role: docker_operations,
      docker_operation: stop_container,
      container_name: app1
    }
```

Post the fault injection, we verify whether the App is running again.
In the real world scenario, we would use the PagerDuty Role in the SRE Framework to verify whether a PagerDuty Alert has been triggered for this event. 


For the sake of our workshop, we would just verify whether the Container App1 is down using the cAdvosir REST API and display the message that an alert is triggered.


```yaml
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

You can copy the following code into your `failover.yaml`

```yaml
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

#### Lets run this playbook

```shell
cd ~/interconnect2017-sreframework/playbooks/
```
---
#### Please Note:
> The file `ansible.cfg` defines the configurations for our Ansible playbooks.

```INI
[defaults]
inventory = ../inventory/hosts
roles_path = ../sreFramework/roles/
library = ../sreFramework/modules
stdout_callback = skippy
display_skipped_hosts = False
```

> We'll learn more about roles and modules in our Exercise 2.

---

Run the `failover.yaml` playbook from `playbooks` folder to have access to the Ansible configurations.

```shell
ansible-playbook exercise_1/failover.yaml
```

#### Expected Output:

```shell
~/interconnect2017-sreframework/playbooks$ ansible-playbook exercise_1/failover.yaml 

PLAY [localhost] ***************************************************************

TASK [setup] *******************************************************************
ok: [localhost]

TASK [Ensure that the app is running] ******************************************
ok: [localhost]

TASK [pip_operations : pip docker-py==1.9.0 to latest] *************************
ok: [localhost]

TASK [docker_operations : stop docker container app1] **************************
ok: [localhost]

TASK [Test the App server failover] ********************************************
ok: [localhost]

TASK [Verify the heartbeat of the killed container] ****************************
ok: [localhost]

TASK [Throw alert if no heartbeat detected] ************************************
ok: [localhost] => {
    "msg": "Triggering the alert for the Container App1"
}

PLAY RECAP *********************************************************************
localhost                  : ok=7    changed=0    unreachable=0    failed=0   


```

_And that's a job well done._ 

We can verify whether the app is still running at <http://localhost>

Also, check the [cAdvisor](http://localhost:8081) Docker Containers list and now you'll see that the App1 container is missing.

We successfully:
* tested the Failover Scenario for our Demo Cloud Service Environment and 
* verified that an alert is triggered every time the Docker Container is killed

#### This SRE framework can be extended in ways you can imagine to enhance the Reliability and Robustness of our Cloud Services.

If you have some extra time and are interested in knowing the SRE Framework in detail, try out the Exercise 2.


