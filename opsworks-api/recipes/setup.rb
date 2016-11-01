instance = search('aws_opsworks_instance', 'self:true').first  


nodejs_app_setup 'api' do  
  nodejs_version node['opsworks-api']['nodejs']['version']
  nodejs_checksum node['opsworks-api']['nodejs']['checksum']
  adminemail "admin@uderm.md"
  subdomain instance['hostname']+".uderm.md"

end  
