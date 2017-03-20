# Exercise 2

## Adding a task to the target module in the SRE Fault Injection Framework

## Encapsulated SRE Framework Architecture

<p align="center">
<img src="https://cloud.githubusercontent.com/assets/2295612/24100051/8f3865ee-0d2f-11e7-8e2a-6fca425876e0.jpg" width="600" height="400">
</p>

The SRE Framework is essentially a GIT submodule that is encapsulated from the Service specific entities like the playbooks and inventory files.


By maintaining it as a GIT submodule, we can include it in the Service GIT repositories and yet have the ability to push new features that the services can leverage.

## Intructions

In this Exercise, let's add a new feature in this encapsulated framework that can be leveraged by our Demo Cloud Service.



