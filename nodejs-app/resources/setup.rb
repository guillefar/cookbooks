property :nodejs_version, String, default: '5.10.1'  
property :nodejs_checksum, String
property :adminemail, String


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

apt_package 'letsencrypt' do
  action :upgrade                     
end

directory "/var/www" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

directory "/root/certs" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end



cookbook_file '/root/.ssh/known_hosts' do
   cookbook 'nodejs-app'
  source 'known_hosts'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end


cookbook_file '/root/certs/server.crt' do
  source 'server.crt'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end


cookbook_file '/root/certs/server.key' do
  source 'server.key'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end




template "/etc/letsencrypt/cli.ini" do
    source "cli.ini.erb"
    mode 0400

    variables(
      domain:      subdomain,
      adminemail:  adminemail,

    )

  end


execute 'getcertbot' do
  command 'wget https://dl.eff.org/certbot-auto'
  creates 'https://dl.eff.org/certbot-auto'
  action :run
  cwd "/opt"
end


execute 'permcertbot' do
  command 'chmod a+x certbot-auto'
  action :run
  cwd "/opt"
end


execute 'linkcertbot' do
  command 'mv certbot-auto /usr/local/bin'
  creates '/usr/local/bin'
  action :run
  cwd "/opt"
end


execute 'runcertbot' do
  command 'certbot-auto --noninteractive --os-packages-only'
  creates '/usr/local/bin'
  action :run
  cwd "/opt"
end



execute 'runcertbot' do
  command 'certbot-auto certonly'
  creates '/usr/local/bin'
  action :run
  cwd "/opt"
end

	




#ssh_known_hosts_entry 'github.com'
#ssh_known_hosts_entry 'gitlab.com'



end  

