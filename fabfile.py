import datetime
import os
from fabric.api import sudo, put, task, run
from fabric.context_managers import cd, settings

initial_token_name = os.getenv('INITIAL_TOKEN_NAME')

@task
def test_user():
    sudo('whoami', user='custapache')


@task
def test_timestamp():
    print('demo44_{}'.format(make_timestamp()))


@task
def make_timestamp():
    return datetime.datetime.now().strftime('%Y%m%d')


@task
def make_backup():
    with cd('/product/apache2/'):
        sudo('tar -zcvf demo44_{}_test.tar.gz demo44/'.format(make_timestamp()))


@task
def pull_package():
    with cd('/tmp'):
        put('app.tar.gz', './')


@task
def extract_package():
    with cd('/tmp'):
        sudo('rm -rf dist*/')
        sudo('tar -xzf app.tar.gz')


@task
def fix_permissions():
    with cd('/product/apache2/'):
        sudo('chown -R custapache:apps demo44/')


@task
def copy_app():
    with cd('/product/apache2/demo44/'):
        sudo('rm -rf angular/ assets/ static/ index.html SDK/')
        sudo('cp -r /tmp/dist/apache/* .')


@task
def copy_token():
    with cd('/product/apache2/demo44/'):
        sudo('cp SDK/lib/token/'+initial_token_name+' SDK/lib/token/domain_token.dat')

@task
def copy_conf_to_tmp():
    with cd('/product/apache2/demo44/SDK/com/accenture/avs/sdk/'):
        sudo('cp -r conf/ /tmp')
        sudo('tar -zcvf conf_{}_bkp.tar.gz /tmp/conf/'.format(make_timestamp()))

@task
def restore_conf_from_tmp():
    with cd('/product/apache2/demo44/SDK/com/accenture/avs/sdk/conf/'):
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
    with cd('/product/apache2/demo44/'):
        sudo('ls')


@task
def deploy():
    pull_package()
    extract_package()
    make_backup()
#    copy_conf_to_tmp()
    copy_app()
    copy_token()
#    restore_conf_from_tmp()
    fix_permissions()
    restart_apache()
    clear_cache()