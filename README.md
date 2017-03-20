# Interconnect-2017 - Session 4486A

## How to Immunize your Cloud Services before the Epidemic strikes


### Technologies involved:

<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/23793540/a3d03abe-0540-11e7-9b21-6e82119c94ce.jpg" width="600" height="400">
</p>

### Lab Architecture:

For the sake of simplicity, lets consider a simple Cloud Service architecture consisting of:

* Two Apache Web Server Docker containers running a cloud App (Container 2 as Backup Server).
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
* Navigate to the **labs \> 4486 \> 4486_Ubuntu-14-04-base** Folder from the Desktop.
* Double-click the **Ubuntu-14-04.vmx** file.
* Click **Power on this virtual machine** in the left panel.
* Log into the Ubuntu VM for our workshop 4486A using the credentials provided on the left panel.
    * Username: localuser
    * Password: passw0rd
* Make sure that you have Internet Connection.
* Make sure that you are able to use a browser and the terminal.
* If all’s well, we are good to go!



Open up the terminal and:


```shell
cd ~
git clone https://github.com/CDSLab/interconnect2017-sreframework.git
cd interconnect2017-sreframework/
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
~/interconnect2017-sreframework/env_setup$ sh setup.sh



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


<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/24097782/a374d0c0-0d24-11e7-9084-8efb2556fcc8.png" >
</p>


And check cAdvisor at:

<http://localhost:8081>

<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/24097794/af58f4f2-0d24-11e7-865b-159251f8908b.png" >
</p>



#### Check the running docker containers 

```shell
docker ps
```

#### Expected output:

```shell
~/interconnect2017-sreframework$ docker ps
CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS                         NAMES
e4eb480fa089        google/cadvisor           "/usr/bin/cadvisor..."   8 minutes ago       Up 7 minutes        0.0.0.0:8081->8080/tcp        cadvisor
d16a5378c7b1        smebberson/alpine-nginx   "/init"                  8 minutes ago       Up 8 minutes        0.0.0.0:80->80/tcp, 443/tcp   loadbalancer
47dc09057d2a        nimmis/alpine-apache      "/boot.sh"               8 minutes ago       Up 8 minutes        80/tcp, 443/tcp               app2
629f049efb94        nimmis/alpine-apache      "/boot.sh"               8 minutes ago       Up 8 minutes        80/tcp, 443/tcp               app1

```

## Finally, lets head on to our [Exercise 1](https://github.com/CDSLab/interconnect2017-sreframework/tree/master/playbooks/exercise_1).
