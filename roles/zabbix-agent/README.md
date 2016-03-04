dj-wasabi.zabbix-agent
=========

This is an role for installing and maintaining the zabbix-agent.

This is one of the 'dj-wasabi' roles which configures your whole zabbix environment. See an list for the complete list:

 * zabbix-server (https://galaxy.ansible.com/list#/roles/2070)
 * zabbix-proxy (https://galaxy.ansible.com/list#/roles/2073)
 * zabbix-javagateway (https://galaxy.ansible.com/list#/roles/2076)
 * zabbix-agent (https://galaxy.ansible.com/list#/roles/2079)

Requirements
------------

This role will work on:
 * Red Hat
 * Debian
 * Ubuntu
 * opensuse

So, you'll need one of those operating systems.. :-)

When you want to automatically create the hosts in the webinterface, you'll need on your own machine the zabbix-api package. You can install this locally with the following command: `pip install zabbix-api`. This ansible role uses the modules from "Cove" found in this pull request: https://github.com/ansible/ansible-modules-extras/pull/44. So all credits goes to this guy!



Role Variables
--------------

There are some variables in de default/main.yml which can (Or needs to) be changed/overriden:

* `agent_server`: The ipaddress for the zabbix-server or zabbix-proxy.

* `agent_serveractive`: The ipaddress for the zabbix-server or zabbix-proxy for active checks.

* `zabbix_version`: This is the version of zabbix. Default it is 2.4, but can be overriden to 2.2 or 2.0.

* `zabbix_repo`: When you already have an repository with the zabbix components, you can set it to False.

* `agent_listeninterface`: On which interface zabbix-agent is listening. Default: eth0


These variables needs to be changed/overriden when you want to make use of the zabbix-api for automatically creating and or updating hosts.

* `zabbix_url`: The url on which the Zabbix webpage is available. Example: http://zabbix.example.com

* `zabbix_api_use`: When you want to make use of the Zabbix-API. Default: False

* `zabbix_api_user`: Username of user which has API access.

* `zabbix_api_pass`: Password for the user which has API access.

* `zabbix_create_hostgroup`: present (Default) if you want to create hostgroups or absent if you not. 

* `zabbix_host_status`: enabled (Default) when host in monitored, disabled when host is disabled for monitoring.

* `zabbix_create_host`: present  # or absent

* `zabbix_useuip`: 1 if connection to zabbix-agent is made via ip, 0 for fqdn.

* `zabbix_host_groups`: An list of hostgroups which this host belongs to.

* `zabbix_link_templates`: An list of templates which needs to be link to this host. The templates should exist.

* `zabbix_macros`: An list with macro_key and macro_value for creating hostmacro's.


Dependencies
------------
There are no dependencies on other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
         - role: dj-wasabi.zabbix-agent
           agent_server: 192.168.33.30
           agent_serveractive: 192.168.33.30
           zabbix_url: http://zabbix.example.com
           zabbix_api_use: true
           zabbix_api_user: Admin
           zabbix_api_pass: zabbix
           zabbix_create_host: present
           zabbix_host_groups:
             - Linux Servers
           zabbix_link_templates:
             - Template OS Linux
             - Apache APP Template
           zabbix_macros:
             - macro_key: apache_type
               macro_value: reverse_proxy

You can also use the group_vars or host_vars for setting some vars.

		cat group_vars/all
		agent_server: 192.168.33.30
        agent_serveractive: 192.168.33.30
        zabbix_url: http://zabbix.example.com
        zabbix_api_use: true
        zabbix_api_user: Admin
        zabbix_api_pass: zabbix
        zabbix_create_host: present
        zabbix_host_groups:
          - Linux Servers
        zabbix_link_templates:
          - Template OS Linux
          - Apache APP Template
        zabbix_macros:
          - macro_key: apache_type
            macro_value: reverse_proxy

and in the playbook only specifying:

    - hosts: all
      roles:
         - role: dj-wasabi.zabbix-agent


Extra Information
----------------

You can install so-called userparameter files by adding the following into your roles:
```
- name: "Installing sample file"
  copy: src=sample.conf
        dest="{{ agent_include }}/mysql.conf"
        owner=zabbix
        group=zabbix
        mode=0755
  notify: "{{ zabbix_agent }} restarted"
```
Example of the "sample.conf" file:
```
UserParameter=mysql.ping_to,mysqladmin -uroot ping | grep -c alive
```

You can extend your zabbix configuration by adding items yourself that do specific checks which aren't in the zabbix core itself. You can change offcourse the name of the file to whatever you want (Same for the UserParameter line(s) ;-) )

License
-------

GPLv3

Author Information
------------------

This is my first attempt to create an ansible role, so please send suggestion or pull requests to make this role better. 

Github: https://github.com/dj-wasabi/ansible-zabbix-agent

mail: ikben [ at ] werner-dijkerman . nl
