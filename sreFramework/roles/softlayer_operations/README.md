softlayer_operations
=========

This role provides all the operations that are to be performed using the SoftLayer API.

Role Variables
--------------

Mandatory variables: 

* sl_operation - You can use any of the SoftLayer API options available [here](https://sldn.softlayer.com/reference/services/SoftLayer_Virtual_Guest#)
* sl_hostname
* sl_api_key
* sl_username


Example Playbooks
----------------

1. This explains how to use the softlayer role in your playbook.

```yaml

---
- hosts: localhost
  roles:
  - {
      role: softlayer_operations,
      sl_operation: getPowerState,
      sl_hostname: <your_sl_hostname>,
      sl_api_key: <your_api_key>,
      sl_username: <your_sl_username>
    }
```



2.This explains how to combine the softlayer roles along with other tasks in your playbook. This also provides a simple example on how you can use the "uri" and "pause" core modules of ansible.


```yaml

---
- hosts: localhost
  roles:
   - {
      role: softlayer_operations,
      sl_operation: powerOff,
      sl_hostname: machine01,
      sl_api_key: 265c25ac2be1d176099abb55f0a3f5d437e4eb932,
      sl_username: user1
    }
   - {
      role: softlayer_operations,
      sl_operation:  powerOn,
      sl_hostname: machine01 ,
      sl_api_key: 265ca5815b4cddcfd68639f002b932,
      sl_username: user1

    }
   - {
      role: softlayer_operations,
      sl_operation:  getPowerState,
      sl_hostname: machine01 ,
      sl_api_key: 265ca5815b4cddc6099abb55f0a3f5d437e4eb932,
      sl_username: user1

    }



  tasks:

  - name: WAITING FOR 3 MINUTES FOR TAKEOVER
    pause: minutes=3



  - name: test uri module
    uri:
      url: https://169.4.30.39:8443/
      validate_certs: yes



```








