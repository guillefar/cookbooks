# get own instances + layer name
instance = search('aws_opsworks_instance', 'self:true').first  

layer = search('aws_opsworks_layer', "layer_id:#{instance['layer_ids'].first}").first

# user layer name as app
#app_data = search('aws_opsworks_app', "name:#{layer['name']}").first  

app_data = search('aws_opsworks_app', "shortname:surveysapi").first  



#revision_string = instance['ec2_instance_id'].spl­it(//).las­t(4).join
#revision = revision_string.­split(//).­first(3).j­oin
revision = layer['shortname']
node['newrelic']['license'] ='9b7c5df40898dff718fd0deb72ecb6b1844c0973'


#app_data = search('aws_opsworks_app', "app_id:1915b21a-5396-47b8-8688-0980e5780d8e").first  
appname=app_data['shortname']


fail 'could not find app' unless app_data

# deploy the application
nodejs_app_deploy 'surveysapi' do
	
  ssh_key app_data['app_source']['ssh_key']
  dir ::File.join(node['opsworks-surveysapi']['basedir'],appname )
  git_repository app_data['app_source']['url']
#  git_revision app_data['app_source']['revision']


git_revision revision


	letsencryptsub instance["hostname"]+".uderm.md"

  run_cmd node['opsworks-surveysapi']['run-cmd']
  run_environment app_data['environment']
end  