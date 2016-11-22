import datetime
import os
from fabric.api import sudo, put, task, run
from fabric.context_managers import cd, settings

@task
def test_user():
    sudo('whoami', user='jboss')

@task
def deploy():
    test_user()
