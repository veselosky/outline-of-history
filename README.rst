Vince's project to build a web site around The Outline of History by H. G. Wells.

To build the site:

    make html

or for a full rebuild:

    make clean html

Deployment now uses Ansible.

    ansible-playbook -i <host_inventory> deploy.yml

The Ansible host must declare the following host vars:

* website_root - directory where sites are installed
* website_user - owner of site files
* website_group - group owner of site files
* http_service - apache2 or nginx

For the moment, the only virtual host config provided is for Apache 2.4.
