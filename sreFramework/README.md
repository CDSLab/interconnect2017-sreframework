SRE Fault Injection Framework
==============================


Getting started:
----------------

First Ansible playbook:
-----------------------

> *Pre-requisites*
> 
> * Ansible 2.0.1.0
> * Python 2.7.10

The only 2 things you need to provide to create a sufficient playbook are:
* hosts
* roles

In this example, we'll fetch the power state of a particular VM using the Softlayer API. 

#### Hosts file:

Path : `<your-git-repo>/inventory/hosts` :

```INI
localhost              ansible_connection=local
<machine_alias>        ansible_host=<machine_ip>         ansible_user=<ssh-user>        ansible_ssh_pass=<ssh-password>
```

Note that for the sample-sl-operation-playbook.yaml example that follows, you do not need to modify this file as it runs locally.

#### Playbook:

Path : `<your-git-repo>/playbooks/sample-sl-operation-playbook.yaml`

Provide the intended Softlayer hostname, username and API key in the sample playbook.  If you do not know your Softlayer API key, you can get it by logging into Softlayer (control.softlayer.com), click on your userID in the upper-right, then scroll down until you see Authentication Key under API Access Information.

```yaml
---
- hosts: localhost
  roles:
  - {
      role: softlayer_operations,
      sl_operation: getPowerState,
      sl_hostname: dashdb-txnha-hadr-01-sby,
      sl_api_key: <your_SL_api_key>,
      sl_username: <your_SL_username>
    }
```

List of available Roles:
------------------------
* [target_operations](https://github.ibm.com/cds-sre-org/sreFramework/tree/dev/roles/target_operations)
* [softlayer_operations](https://github.ibm.com/cds-sre-org/sreFramework/tree/dev/roles/softlayer_operations)
* [pagerduty_operations](https://github.ibm.com/cds-sre-org/sreFramework/tree/dev/roles/pagerduty_operations)
* [docker_operations](https://github.ibm.com/cds-sre-org/sreFramework/tree/dev/roles/docker_operations)
* [network_operations](https://github.ibm.com/cds-sre-org/sreFramework/tree/dev/roles/network_operations)


Running the playbook:
---------------------

Lets run this sample playbook:

```sh
cd <your-git-repo>/playbooks/
```

```sh
sudo ansible-playbook sample-sl-operation-playbook.yaml -vv
```


You can see the Ansible output displaying the Power State of your machine in this example.







