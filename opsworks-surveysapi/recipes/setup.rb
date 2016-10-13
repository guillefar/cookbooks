

nodejs_app_setup 'surveysapi' do  
  nodejs_version node['opsworks-surveysapi']['nodejs']['version']
  nodejs_checksum node['opsworks-surveysapi']['nodejs']['checksum']
end  
