#   setup attributes
default['opsworks-api']['nodejs']['version'] = '6.5.0'  
default['opsworks-api']['nodejs']['checksum'] = 'd7742558bb3331e41510d6e6f1f7b13c0527aecc00a63c3e05fcfd44427ff778'
default['opsworks-api']['nodejs']['adminemail'] = "admin@uderm.md"

# 12d5b79b8b914c2439b6aa542b47f28c0d6dc9c5438eeda629f26021eb839dac


#SHA512 node-v6.5.0-linux-x64.tar.gz 575638830e4ba11c5afba5c222934bc5e338e74df2f27ca09bad09014b4aa415


#8737539ff6e9341add78bf2e72932d62e8d830fc59449f97350dc60cc7c19805


#   deploy attributes
default['opsworks-api']['basedir'] = '/var/www/'  
default['opsworks-api']['run-cmd'] = '/usr/bin/node /var/www/api/server.js'
  default['opsworks-api']['restart'] = 'always'
#default['opsworks-api']['ssh_key']  =
#run_environment(
#    'NODE_ENV' => 'production',
#    'PORT' => 8080
#  )

