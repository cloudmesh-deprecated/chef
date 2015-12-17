default['slurm']['version'] = '14.11.7'
default['slurm']['download_url'] = "http://www.schedmd.com/download/latest/slurm-#{node['slurm']['version']}.tar.bz2"
default['slurm']['download_dir'] = Chef::Config[:file_cache_path]
default['slurm']['checksum'] = '191148a2e7043a158c72e7b426c545c439d684c1205a9c19e25c3aa8f8cef77a'
default['slurm']['prefix'] = ''
default['slurm']['sysconfdir'] = "#{node['slurm']['prefix']}/etc"
default['slurm']['node_list'] = 'node[001-010]'
default['slurm']['role'] = 'execute'
default['slurm']['cluster_name'] = 'slurm_cluster'

# TODO: Determine user and group information.
default['slurm']['user'] = 'slurm'
default['slurm']['uid'] = '1002'
default['slurm']['group'] = 'slurm'
default['slurm']['gid'] = '1001'
