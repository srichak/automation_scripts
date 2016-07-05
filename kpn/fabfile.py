import datetime
import os
from fabric.api import sudo, put, task, run
from fabric.context_managers import cd, settings

deployment_name = os.getenv('DEPLOYMENT_NAME')
deployment_package = os.getenv('DEPLOYMENT_PACKAGE')
@task
def test_user():
    sudo('whoami', user='custapache')


@task
def test_timestamp():
    print(deployment_name+'_{}'.format(make_timestamp()))


@task
def make_timestamp():
    return datetime.datetime.now().strftime('%Y-%m-%d_%H-%M')


@task
def make_backup():
    with cd('/product/apache2/'):
        sudo('tar -zcvf '+deployment_name+'_{}_bkp.tar.gz '+deployment_name+'/'.format(make_timestamp()))


@task
def pull_package():
    with cd('/tmp'):
        put(deployment_package, './')


@task
def extract_package():
    with cd('/tmp'):
        sudo('rm -rf dist*/')
        sudo('tar -xzf '+deployment_package)


@task
def fix_permissions():
    with cd('/product/apache2/'):
        sudo('chown -R custapache:apps '+deployment_name+'/')


@task
def copy_app():
    with cd('/product/apache2/'+deployment_name+'/'):
        sudo('rm -rf angular/ assets/ static/ index.html SDK/')
        sudo('cp -r /tmp/dist/apache/* .')


@task
def copy_conf_to_tmp():
    with cd('/product/apache2/'+deployment_name+'/SDK/com/accenture/avs/sdk/'):
        sudo('cp -r conf/ /tmp')
        sudo('tar -zcvf conf_{}_bkp.tar.gz /tmp/conf/'.format(make_timestamp()))

@task
def restore_conf_from_tmp():
    with cd('/product/apache2/'+deployment_name+'/SDK/com/accenture/avs/sdk/conf/'):
        sudo('cp -r /tmp/conf/* .')

@task
def restart_apache():
    with cd('/product/apache2/bin/'):
        sudo('./apachectl restart', user='custapache')


@task
def clear_cache():
    with cd('/product/varnish/bin/'):
        run('./varnishadm \'ban req.url ~ \".\"\'')
     

@task
def ls():
    with cd('/product/apache2/'+deployment_name+'/'):
        sudo('ls')


@task
def deploy():
    pull_package()
    extract_package()
    make_backup()
    #copy_app()
    #fix_permissions()
    #restart_apache()
    #clear_cache()

@task
def deploy_no_sudo():
    pull_package()
    extract_package_no_sudo()
    make_backup_no_sudo()
    #copy_app()
    #fix_permissions()
    #restart_apache()
    #clear_cache()


@task
def make_backup_no_sudo():
    with cd('/product/apache2/'):
        run('tar -zcvf +deployment_name+_{}_bkp.tar.gz '+deployment_name+'/'.format(make_timestamp()))



@task
def extract_package_no_sudo():
    with cd('/tmp'):
        run('rm -rf pctv*/')
        run('tar -xzf '+deployment_package)


@task
def fix_permissions_no_sudo():
    with cd('/product/apache2/'):
        run('chown -R custapache:apps '+deployment_name+'/')


@task
def copy_app_no_sudo():
    with cd('/product/apache2/'+deployment_name+'/'):
        run('rm -rf config/ css/ fonts/ images/ index.html/ js/ lib/ templates/ version.json')
        run('cp -r /tmp/pctv/dist/* .')


@task
def copy_conf_to_tmp_no_sudo():
    with cd('/product/apache2/'+deployment_name+'/'):
        run('cp -r json/ /tmp')
        run('tar -zcvf json_{}_bkp.tar.gz /tmp/json/'.format(make_timestamp()))

@task
def restore_conf_from_tmp_no_sudo():
    with cd('/product/apache2/'+deployment_name+'/'):
        run('cp -r /tmp/json/* .')

@task
def restart_apache_no_sudo():
    with cd('/product/apache2/bin/'):
        run('./apachectl restart')
