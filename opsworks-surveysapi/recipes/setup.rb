instance = search('aws_opsworks_instance', 'self:true').first  


nodejs_app_setup 'surveysapi' do  
  nodejs_version node['opsworks-surveysapi']['nodejs']['version']
  nodejs_checksum node['opsworks-surveysapi']['nodejs']['checksum']
  adminemail "admin@uderm.md"
  subdomain instance['hostname']+".uderm.md"

end  
