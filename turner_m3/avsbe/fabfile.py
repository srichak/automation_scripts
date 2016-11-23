import datetime
import os
from fabric.api import sudo, put, task, run
from fabric.context_managers import cd, settings


@task
def stop_jboss_be():
    sudo('ps -ef | grep standalone_be.xml')
    sudo('echo kill -i process')

@task
def get_package():
    sudo('mkdir -p /tmp/avsbe-deployment', user='jboss')
    put('AVS.war', '/tmp/avsbe-deployment')

@task
def make_timestamp():
    return datetime.datetime.now().strftime('%Y%m%d')

@task
def make_backup():
    with cd('/product/jboss/standalone/deployments'):
        sudo('echo mv AVS.war AVS.war.{}'.format(make_timestamp()), user='jboss')

@task
def deploy_package():
    with cd('/product/jboss/standalone/deployments'):
        sudo('echo cp /tmp/avsbe-deployment/AVS.war .', user='jboss')
        sudo('echo chown jboss AVS.war')

@task
def start_jboss_be():
    with cd('/product/jboss/bin/'):
        sudo('echo nohup ./standalone.sh -c=standalone_be.xml -b=0.0.0.0 -bmanagement=0.0.0.0', user='jboss')
       # sudo('nohup ./standalone.sh -c=standalone_be.xml -b=0.0.0.0 -bmanagement=0.0.0.0 &', user='jboss')

@task
def deploy():
    stop_jboss_be()
    get_package()
    #make_backup()
    #deploy_package()
    #start_jboss_be()
