

nodejs_app_setup 'nodejs-app' do  
  nodejs_version node['opsworks-surveysapi']['nodejs']['version']
  nodejs_checksum node['opsworks-surveysapi']['nodejs']['checksum']
end  
