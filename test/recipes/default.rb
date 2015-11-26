postgres_password = 'password'

include_recipe 'apt::default'

node.override['apache']['default_site_enabled'] = false
include_recipe 'apache2::default'
include_recipe 'apache2::mod_wsgi'

node.override['formatron_postgresql']['postgres_password'] = postgres_password
include_recipe 'formatron_postgresql::default'

node.override['formatron_graphite']['secret'] = 'secret'
node.override['formatron_graphite']['timezone'] = 'Europe/Amsterdam'
node.override['formatron_graphite']['postgresql']['user'] = 'postgres'
node.override['formatron_graphite']['postgresql']['password'] = postgres_password
node.override['formatron_graphite']['database']['host'] = 'localhost'
node.override['formatron_graphite']['database']['port'] = 5432
node.override['formatron_graphite']['database']['name'] = 'graphite'
node.override['formatron_graphite']['database']['user'] = 'graphite'
node.override['formatron_graphite']['database']['password'] = 'graphitepassword'
node.override['formatron_graphite']['root_user'] = 'root'
node.override['formatron_graphite']['root_firstname'] = 'root'
node.override['formatron_graphite']['root_lastname'] = 'dude'
node.override['formatron_graphite']['root_password'] = 'password'
node.override['formatron_graphite']['root_email'] = 'me@mydomain.com'
include_recipe 'formatron_graphite::default'
apache_site 'graphite'

node.override['formatron_grafana']['admin']['user'] = 'root'
node.override['formatron_grafana']['admin']['password'] = 'password'
node.override['formatron_grafana']['postgresql']['user'] = 'postgres'
node.override['formatron_grafana']['postgresql']['password'] = postgres_password
node.override['formatron_grafana']['database']['host'] = 'localhost'
node.override['formatron_grafana']['database']['port'] = 5432
node.override['formatron_grafana']['database']['name'] = 'grafana'
node.override['formatron_grafana']['database']['user'] = 'grafana'
node.override['formatron_grafana']['database']['password'] = 'grafanapassword'
include_recipe 'formatron_grafana::default'

formatron_grafana_datasource 'local_graphite' do
  type 'graphite'
  url 'http://localhost'
  access 'proxy'
  basic_auth false
end
