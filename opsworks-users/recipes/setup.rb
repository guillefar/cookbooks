instance = search('aws_opsworks_instance', 'self:true').first  


nodejs_app_setup 'users' do  
  nodejs_version node['opsworks-users']['nodejs']['version']
  nodejs_checksum node['opsworks-users']['nodejs']['checksum']
  adminemail "admin@uderm.md"
  subdomain instance['hostname']+".uderm.md"

end  
