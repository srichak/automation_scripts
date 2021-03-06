import datetime
import os
from fabric.api import sudo, put, task, run
from fabric.context_managers import cd, settings

ansible_path = os.getenv('ANSIBLE_PATH')
invetory_file_path = os.getenv('INVENTORY_FILE_PATH')
ansible_tags = os.getenv('ANSIBLE_TAGS')
ansible_playbook_name = os.getenv('ANSIBLE_PLAYBOOK_NAME')
vault_pass_file = os.getenv('VAULT_PASS_FILE')
extra_vars = os.getenv('EXTRA_VARS')

@task
def test_ansible():
    sudo('ansible --list-hosts all')

@task
def deploy():
	with cd(ansible_path):
		sudo('ansible-playbook -vvvv -i '+invetory_file_path+' '+ansible_tags+' '+ansible_playbook_name+' '+vault_pass_file+' '+extra_vars)
