# get own instances + layer name
instance = search('aws_opsworks_instance', 'self:true').first  
layer = search('aws_opsworks_layer', "layer_id:#{instance['layer_ids'].first}").first

# user layer name as app
app_data = search('hello_world', "name:#{layer['name']}").first  
fail 'could not find app' unless app_data

# deploy the application
nodejs_app_deploy '<node></node>-app' do  
  ssh_key app_data['app_source']['ssh_key']
  dir ::File.join(node['opsworks-surveysapi']['basedir'], app_data['name'])
  git_repository app_data['app_source']['url']
  git_revision app_data['app_source']['revision']
  run_cmd node['opsworks-surveysapi']['run-cmd']
  run_environment app_data['environment']
end  