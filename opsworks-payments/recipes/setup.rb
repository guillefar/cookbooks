instance = search('aws_opsworks_instance', 'self:true').first  


nodejs_app_setup 'payments' do  
  nodejs_version node['opsworks-payments']['nodejs']['version']
  nodejs_checksum node['opsworks-payments']['nodejs']['checksum']
  adminemail "admin@uderm.md"
  subdomain instance['hostname']+".uderm.md"

end  
