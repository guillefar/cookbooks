property :nodejs_version, String, default: '5.10.1'  
property :nodejs_checksum, String





default_action :run

action :run do  
  # 1. install git
  include_recipe 'git'

  # 2. install nodejs
  node.default['nodejs']['install_method'] = 'binary'
  node.default['nodejs']['version'] = nodejs_version
#  node.default['nodejs']['binary']['checksum']['linux_x64'] = nodejs_checksum
  include_recipe 'nodejs'
  include_recipe 'nodejs::npm'
end  