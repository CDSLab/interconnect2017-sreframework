# Exercise 2

## Adding a task to the target module in the SRE Fault Injection Framework

## Encapsulated SRE Framework Architecture

<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/24100051/8f3865ee-0d2f-11e7-8e2a-6fca425876e0.jpg" width="600" height="400">
</p>

The SRE Framework is essentially a GIT submodule that is encapsulated from the Service specific entities like the playbooks and inventory files.


By maintaining it as a GIT submodule, we can include it in the Service GIT repositories and yet have the ability to push new features that the services can leverage.

## Intructions

In **Exercise 1**, we stopped and removed the Container **app1** using the docker_operation - **stop_container**.


In this Exercise, let's add a new docker operation - **start_container** in this encapsulated framework.


This operation will be used to start our killed Container 'app1'.

_Let's get going._

```shell
cd ~/interconnect2017-sreframework/sreFramework/roles/docker_operations/tasks/
```

> In simple words, Ansible Roles provide _organization_ to your tasks and playbooks.

#### To enable the `docker_operations` role to have a new operation called `start_container`:

Open up the file `main.yml` and add this piece of code at the end of the file.

```yaml
- include: ./start_container.yml
  when: docker_operation == "start_container"
```

Create a new file `start_container.yml`

```shell
vim start_container.yml
```

```yaml
---
- name: start docker container {{ container_name }} from image {{ image_name }}
  docker_container:
    name: "{{ container_name }}"
    image: "{{ image_name }}"
    state: started

```

That's pretty much it.

This new operation expects the `container_name` and the `image_name` to get going and start that container for you.

---

#### Lets create a playbook to start the container _app1_.

```shell
cd ~/interconnect2017-sreframework/playbooks/exercise_2/
vim start_app1.yaml
```

```yaml
---
- hosts: localhost
  roles:
  - {
      role: docker_operations,
      docker_operation: start_container,
      container_name: app1,
      image_name: nimmis/alpine-apache
    }
  post_tasks:
    - name: Verify the heartbeat of the started container
      uri:
        url: http://localhost:8081/api/v1.3/docker/app1
```

#### Running the _start_app1.yaml_

```shell
cd ~/interconnect2017-sreframework/playbooks/
ansible-playbook exercise_2/start_app1.yaml
```

#### Expected output:

```shell

```









