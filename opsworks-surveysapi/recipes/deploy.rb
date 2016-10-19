# get own instances + layer name
instance = search('aws_opsworks_instance', 'self:true').first  
layer = search('aws_opsworks_layer', "layer_id:#{instance['layer_ids'].first}").first

# user layer name as app
#app_data = search('aws_opsworks_app', "name:#{layer['name']}").first  

app_data = search('aws_opsworks_app', "shortname:surveysapi").first  

#app_data = search('aws_opsworks_app', "app_id:1915b21a-5396-47b8-8688-0980e5780d8e").first  

fail 'could not find app' unless app_data

# deploy the application
nodejs_app_deploy 'surveysapi' do  
  ssh_key app_data['app_source']['ssh_key']
  dir ::File.join(node['opsworks-surveysapi']['basedir'], app_data['shortname'])
  git_repository app_data['app_source']['url']
#  git_revision app_data['app_source']['revision']

 # NombreAppSTG1
 revision_string=app_data['app_source']['revision'].to_s
 revision=revision_string[-4..-2­]
  if revision?("dev")
      git_rev="dev"
    elsif revision?("stg")   
      git_rev="stage"
    elsif revision?("mas")   
      git_rev="master"
    end

git_revision git_rev



  run_cmd node['opsworks-surveysapi']['run-cmd']
  run_environment app_data['environment']
end  