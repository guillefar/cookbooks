

nodejs_app_setup 'nodejs-app' do  
  nodejs_version node['opsworks-nodejs-app']['nodejs']['version']
  nodejs_checksum node['opsworks-nodejs-app']['nodejs']['checksum']
end  
