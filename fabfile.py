from fabric.api import env, lcd, local, task
import otto.web as web
from otto.util import paths

env['otto.build_dir'] = 'build/staged'
env['otto.site'] = 'outline-of-history.mindvessel.net'
env['otto.home'] = '/home/vince/websites'

@task
def B():
    """Set remote host to boadicea.octoped.net"""
    env.hosts.append('boadicea.octoped.net')

@task
def build():
    """Build the site"""
    target = env['otto.build_dir']
    with lcd(paths.local_workspace()):
        local('sphinx-build -n -d build/doctrees -b html source %s/htdocs' % target)
        local('cp -a etc %s/' % target)

@task
def clean():
    """Clean up stale build files and tarballs"""
    with lcd(paths.local_workspace()):
        local('rm -rf build/*')
        local('rm -f *.tar.gz')
        local("find . -name '*.py[co]' | xargs rm")
