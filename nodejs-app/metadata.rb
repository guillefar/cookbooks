name 'nodejs-app'
maintainer 'guillofar'
maintainer_email 'guillofar@gmail.com'
license 'Apache 2.0'
description 'Installs and Configures node.js, deploys the app'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/guillefar/SurveysApiCookbook' if respond_to?(:source_url)
issues_url 'https://github.com/guillefar/SurveysApiCookbook/issues' if respond_to?(:issues_url)
version '0.0.1'

depends 'yum-epel'
depends 'dmg'
depends 'build-essential'
depends 'ark'
depends 'apt'
depends 'homebrew'
depends 'nodejs'
depends 'git'




%w(debian ubuntu centos redhat scientific oracle amazon smartos mac_os_x).each do |os|
  supports os
end



