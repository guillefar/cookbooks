
nodejs_app_setup 'surveysapi' do  
  nodejs_version node['opsworks-surveysapi']['nodejs']['version']
  nodejs_checksum node['opsworks-surveysapi']['nodejs']['checksum']
  nodejs_adminemail "admin@uderm.md"
  subdomain node["opsworks"]["instance"]["hostname"]+".uderm.md"

end  
