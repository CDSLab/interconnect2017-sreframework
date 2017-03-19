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

### Instructions:

_First things First..._
* Log into the Ubuntu VM for our workshop 4486A using the credentials provided on the screen.
* Make sure that you have Internet Connection.
* Make sure that you are able to use a browser and the terminal.
* If all’s well, we are good to go!


Open up the terminal.


```shell
git clone https://github.com/CDSLab/interconnect2017-sreframework.git
```

```shell
cd interconnect2017-sreframework
```

#### Understanding the directories:

| File/Folder        | Explanation   |
| ------------- |:-------------:|
| env_setup      | Contains the files to setup the Demo Cloud service environment for our workshop |
| inventory      | Holds the Ansible inventory files    |
| playbooks | Contains the Ansible playbooks that we are going to code as a part of this workshop      |
| sreFramework | Underlying Ansible-based SRE Framework leveraged by the Cloud Services to inject faults in their Environments |

### Environment setup:

Let's quickly setup the demo service environment for our workshop.

```shell
cd env_setup
```

```shell
sh setup.sh
```

#### Expected output:

```shell
~/github/interconnect2017-sreframework/env_setup$ sh setup.sh



*********** INITIATING SETUP **************

>> Pulling the required docker images...
>> Docker images pulled.

>> Starting the Apache containers...
Apache containers started successfully.

>> Setting up the NginX Load Balancer...
>> Load Balancer setup completed.

>> Setting up CAdvisor to monitor the containers...
>> CAdvisor set up successfully.

*********** SETUP COMPLETED **************

App:  http://localhost
CAdvisor: http://localhost:8081


```

Now you have a running Demo Cloud Service environment in your VM.

Open up a browser to check the running app at:

<http://localhost>

And check cAdvisor at:

<http://localhost:8081>
