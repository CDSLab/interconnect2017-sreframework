SRE Fault Injection Framework
==============================


Getting started:
----------------
Ideally, the SRE Framework is provided as a GIT submodule to the GIT repositories wanting to utilize the framework.


Updating the `sreFramework` Git Submodule: 
------------------------------------------

Your Git repo contains a folder called `sreFramework`. This folder is the SRE Fault Injection Framework that you would be using to inject faults, detect alerts and test the reliability of your service.

This `sreFramework` is a Git submodule within your Git repo which means that it is linked to our sreFramework Git repo and you can utilize the files in there like they are in your own Git repo.

From within your cloned repo folder, run the below command to update the Git submodule to the latest version:

```sh
git submodule update --remote --recursive
```


It is a good practice to keep the submodule updated using the command above.



### NOTE: For the sake of our workshop, we have included the SRE Framework as a directory within the GIT repo and not a Submodule.


> *Pre-requisites*
> 
> * Ansible 2.0.1.0
> * Python 2.7.10

The only 2 things you need to provide to create a sufficient playbook are:
* hosts
* roles


List of available Roles:
------------------------
* target_operations
* softlayer_operations
* pagerduty_operations
* docker_operations
* network_operations


