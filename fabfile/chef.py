import platform

from fabric.api import local, task
from fabric.context_managers import lcd

def _control_server(command):
    local('sudo chef-server-ctl {0}'.format(command))

def _get_distro():
    return platform.linux_distribution()[0]

def _install_centos():
    download_url = 'https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-server-11.0.8-1.el6.x86_64.rpm'
    package_name = 'chef-server.rpm'

    with lcd('/tmp'):
        local('curl -o {0} {1}'.format(package_name, download_url))
        local('sudo yum -y localinstall {0}'.format(package_name))
    local('sudo chef-server-ctl reconfigure')

def _install_ubuntu():
    download_url = 'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb'
    package_name = 'chef-server.deb'

    with lcd('/tmp'):
        local('curl -o {0} {1}'.format(package_name, download_url))
        local('sudo dpkg -i {0}'.format(package_name))
    local('sudo chef-server-ctl reconfigure')

def _uninstall_centos():
    pass

def _uninstall_ubuntu():
    pass

@task
def clean():
    """Remove data from the Chef Server"""
    pass

@task
def info():
    """Outputs Chef Server information and Chef artifacts"""
    pass

@task
def install():
    """Installs Chef Server on either CentOS or Ubuntu"""
    distro = _get_distro()

    if distro == "Ubuntu":
        _install_ubuntu()
    elif distro == "CentOS":
        _install_centos()
    else:
        local('echo "Unsupported operating system distribution."')

@task
def kill():
    """Removes data from the Chef Server and stops the service"""
    clean()
    stop()

@task
def start():
    """Start the Chef Server service"""
    _control_server('start')

@task
def stop():
    """Stop the Chef Server service"""
    _control_server('stop')

@task
def uninstall():
    """Uninstall the Chef Server"""
    distro = _get_distro()

    _control_server('uninstall')
    if distro == "Ubuntu":
        _uninstall_ubuntu()
    elif distro == "CentOS":
        _uninstall_centos()
    else:
        local('echo "Unsupported operating system distribution."')
