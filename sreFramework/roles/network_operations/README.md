network_operations
=================

This role provides all the networking operations that are to be performed `ssh`ing into the target machine.

Role Variables
--------------

Mandatory variable: `network_operation`

Depending on the value of `network_operation`, additional variables are required as follows:

|     network_operation             |            Description                  |Other Req Var's | Type    |
|:---------------------------------:|:---------------------------------------:|:--------------:|:-------:|
|  blockFromIp                      | blocks incoming from specified ipaddress| ipAddress      |  List   |  
|  undo_blockFromIp                 | undo "blockFromIp" task based on the ip | ipAddress      |  List   |
|  blockToIp                        | blocks outgoing to specified ipaddress  | ipAddress      |  List   |
|  undo_blockToIp                   | undo "blockToIp" task based on the ip   | ipAddress      |  List   |
|  block_all_incoming               | block all incoming connections          |     -          |    -    |
|  undo_block_all_incoming          | undo "block_all_incoming"  task         |     _          |    _    |
|  block_all_outgoing               | block all outgoing connections          |     _          |    -    |               
|  undo_block_all_outgoing          | undo "block_all_outgoing" task          |     _          |    _    |
|  block_by_domainName              | block connections based on domain name  | domainName     |  List   |
|  undo_block_by_domainName         | undo "block_by_domainName" task         | domainName     |  List   |
|  restart_network_interface        | restart network interfaces              | interface_name,|         |
|                                   |                                         |  timeInterval  |         |


Example Playbooks
----------------
1. blockFromIp & undo_blockFromIp 
```yaml

---
- hosts: networkops
  roles:
   - {
      role: network_operations,
      ipAddress : ['10.155.161.234','169.45.164.217'],
      network_operation : blockFromIp
    }
   - {
      role: network_operations,
      ipAddress : "{{ipAddress_Value}}",
      network_operation : undo_blockFromIp
    }


```
NOTE: ipAdress can be a list.It can be specified as ['10.155.161.234','169.45.164.217'] or "{{ipAddress_Value}}", where we can globally declare "ipAddress_Value" in your_repo/inventory/group_vars/all as ipAddress_Value:  ['10.155.161.234','169.45.164.217' ]



2. block_all_incoming & undo_block_all_incoming

 ```yaml
---
- hosts: networkops
  roles:
   - {
      role: network_operations,
      network_operation : block_all_incoming
     }
   - {
      role: network_operations,
      network_operation : undo_block_all_incoming
     }


```yaml



3. block_by_domainName
 

 ```yaml

---
- hosts: networkops
  roles:
   - {
      role: network_operations,
      network_operation : undo_block_by_domainName,
      domainName : ['www.cloudant.com','www.google.com','www.facebook.com']
    }

NOTE: domainName can be a list.It can be specified as ['www.cloudant.com','www.google.com','www.facebook.com'] or as "{{domainName}}", where we can globally declare "domainName" in your_repo/inventory/group_vars/all as domainName:  ['www.cloudant.com','www.facebook.com' ]


```yaml



4. Restart Network
```yaml

---
- hosts: networkinterfaces
  roles:
  - {
      role: network_operations,
      network_operation: restart_network_interface,
      interface_name: eth0
      timeInterval: 10 
    }
```




NOTE: make sure you have ansible >= 1.3 to use the "restart_networkInterfaces" operation with the sleep feature
