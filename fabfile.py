import datetime
from fabric.api import sudo, put, task, run
from fabric.context_managers import cd, settings


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
        sudo(
            'tar -zcvf demo44_{}_test.tar.gz demo44/'.format(make_timestamp()))


@task
def pull_package():
    with cd('/tmp'):
        put('app.tar.gz', './')


@task
def extract_package():
    with cd('/tmp'):
        run('rm -rf dist*/')
        run('tar -xzf app.tar.gz')


@task
def fix_permissions():
    with cd('/product/apache2/'):
        sudo('chown -R custapache:apps demo44/')


@task
def copy_app():
    with cd('/product/apache2/demo44/'):
        sudo('rm -rf angular/ assets/ static/ index.html SDK/')
        sudo('cp -r /tmp/dist/* .')


@task
def restart_apache():
    with cd('/product/apache2/bin/'):
        sudo('./apachectl restart', user='custapache')


@task
def clear_cache():
    with cd('/product/varnish/bin/'), settings(prompts={'Type \'quit\' to close CLI session.': 'quit'}):
        run('./varnishadm && echo \"ban req.url ~ \".\"\"')
     

@task
def ls():
    with cd('/product/apache2/demo44/'):
        sudo('ls')


@task
def deploy():
    pull_package()
    extract_package()
    copy_app()
    fix_permissions()
    restart_apache()
    clear_cache()
