property :ssh_key, String  
property :dir, String, required: true  
property :git_repository, String, required: true  
property :git_revision, String, default: 'master'  
property :service_name, String, required: true, name_property: true  
property :run_cmd, String, default: '/usr/local/bin/npm start'  
property :run_environment, Hash, default: {}



default_action :run

action :run do  

#  file '/root/.ssh/id_rsa' do
#    mode '0400'
#    content ssh_key
#  end
directory "/var/www" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end


link '/usr/bin/node' do
  to '/usr/bin/nodejs'
end
  

template "/root/.ssh/id_rsa" do
    source "id_rsa.erb"
    mode 0400

    variables(
      key:      node[:deploy][:surveysapi][:git_key] 
    )

  end


file "/root/.ssh/known_hosts" do
  content "=|E/l7LDYhQPHsYe0sAA1NxaCC68U= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=
=|M+qWQrpqFhGiPDNQeknjA5tp/zQ= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY="

  owner 'root'
  group 'root'
  mode '0400'
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
      host:      node[:deploy][:surveysapi][:database][:host] ,
      user:       node[:deploy][:surveysapi][:database][:username] ,
      password:   node[:deploy][:surveysapi][:database][:password] ,
      db:         node[:deploy][:surveysapi][:database][:database] ,
    )

  end




  service service_name do
    provider Chef::Provider::Service::Systemd

   action [:enable, :stop]
   action [:start]

#    action :start
#    subscribes :restart, "git[#{dir}]", :delayed
 #   subscribes :restart, "execute[npm prune #{service_name}]", :delayed
 #   subscribes :restart, "execute[npm install #{service_name}]", :delayed

  end



end  