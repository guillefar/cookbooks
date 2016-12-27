property :ssh_key, String  
property :dir, String, required: true  
property :git_repository, String, required: true  
property :git_revision, String, default: 'master'  
property :service_name, String, required: true, name_property: true  
property :run_cmd, String, default: '/usr/local/bin/npm start'  
property :run_environment, Hash, default: {}
property :letsencryptsub, String  
property :webroot, String


default_action :run

action :run do  

  include_recipe 'newrelic'
#    node['newrelic']['license'] ='9b7c5df40898dff718fd0deb72ecb6b1844c0973'
#  file '/root/.ssh/id_rsa' do
#    mode '0400'
#    content ssh_key
#  end


link '/usr/bin/node' do
  to '/usr/bin/nodejs'
end
  

template "/root/.ssh/id_rsa" do
    source "id_rsa.erb"
    mode 0400

    variables(
      key:      node[:deploy][:nodeapp][:git_key] 
    )

  end





  git dir do
    repository git_repository
    revision git_revision
    action :sync
  end

#  execute "npm prune #{service_name}" do
  execute "npm prune #{service_name}" do
    command 'npm prune'
    cwd dir
  end

  execute "npm install #{service_name} #{dir} " do
    cwd dir
    command 'npm install'
  end

  template "/etc/systemd/system/#{service_name}.service" do
    source 'systemd.conf.erb'
    cookbook 'nodejs-app'
    mode '0600'
    variables(
      name: service_name,
      chdir: dir,
      cmd: run_cmd,
      environment: run_environment
    )
    notifies :stop, "service[#{service_name}]", :delayed
    notifies :start, "service[#{service_name}]", :delayed
  end


 template "#{dir}/config/local.js" do
    source "local.js.erb"
    mode 0660
    group "www-data"

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")   
      owner "apache"
    end

    variables(
      host:      node[:deploy][:nodeapp][:database][:host] ,
      user:       node[:deploy][:nodeapp][:database][:username] ,
      password:   node[:deploy][:nodeapp][:database][:password] ,
      db:         node[:deploy][:nodeapp][:database][:database] ,
      subdomain: letsencryptsub
    )

  end




  service service_name do
    provider Chef::Provider::Service::Systemd

   action [:enable]

  end
  service service_name do
    provider Chef::Provider::Service::Systemd

      action [:stop]

  end
  service service_name do
    provider Chef::Provider::Service::Systemd

   action [:start]

#    action :start
#    subscribes :restart, "git[#{dir}]", :delayed
 #   subscribes :restart, "execute[npm prune #{service_name}]", :delayed
 #   subscribes :restart, "execute[npm install #{service_name}]", :delayed

  end



newrelic_server_monitor 'Install' do
  license '9b7c5df40898dff718fd0deb72ecb6b1844c0973'
end

newrelic_agent_nodejs webroot do

  license '9b7c5df40898dff718fd0deb72ecb6b1844c0973'

end




end