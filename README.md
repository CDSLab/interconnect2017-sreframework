# Interconnect-2017 - Session 4486A

## How to Immunize your Cloud Services before the Epidemic strikes


### Technologies involved:

<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/23793540/a3d03abe-0540-11e7-9b21-6e82119c94ce.jpg" width="600" height="400">
</p>

### Lab Architecture:

For the sake of simplicity, lets consider a simple Cloud Service architecture consisting of:

* Two Apache Web Server Docker containers running a cloud App (Container 2 for failover scenario).
* One NginX Load Balancer Docker container.
* A cAdvisor Docker container monitoring the host machine as well as the Docker containers in the Cloud Service.


<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/24083037/e87e6ec6-0c8c-11e7-8fa3-cbd15a37f39c.jpg" width="600" height="400">
</p>


### Target for the Lab:

* Get familiar with Ansible and how it can make a Cloud Engineer **_#sleepmore_**
* **Exercise 1**
    > Code and run an Ansible Playbook to test the Failover scenario for our Demo Cloud Service.
* **Exercise 2**
    > Understand the encapsulated SRE framework and design a new Role to automate Fault Injections.






