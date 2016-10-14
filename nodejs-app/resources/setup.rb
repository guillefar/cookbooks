property :nodejs_version, String, default: '5.10.1'  
property :nodejs_checksum, String
require 'ssh_known_hosts'




default_action :run

action :run do  
  # 1. install git
  include_recipe 'git'

  # 2. install nodejs
  node.default['nodejs']['install_method'] = 'package'
#  node.default['nodejs']['version'] = nodejs_version
#  node.default['nodejs']['binary']['checksum']['linux_x64'] = nodejs_checksum
#  include_recipe 'nodejs'
  node.default['nodejs']['npm']['install_method'] = 'package'
  include_recipe 'nodejs::npm'





apt_package 'npm' do
  action :upgrade                     
end

directory "/var/www" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

ssh_known_hosts_entry 'github.com'
ssh_known_hosts_entry 'gitlab.com'



end  

