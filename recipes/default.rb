admin_user = node['formatron_grafana']['admin']['user']
admin_password = node['formatron_grafana']['admin']['password']
postgres_user = node['formatron_grafana']['postgresql']['user']
postgres_password = node['formatron_grafana']['postgresql']['password']
database_host = node['formatron_grafana']['database']['host']
database_port = node['formatron_grafana']['database']['port']
database_name = node['formatron_grafana']['database']['name']
database_user = node['formatron_grafana']['database']['user']
database_password = node['formatron_grafana']['database']['password']
ldap_server = node['formatron_grafana']['ldap_server']
ldap_port = node['formatron_grafana']['ldap_port']
ldap_search_base = node['formatron_grafana']['ldap_search_base']
ldap_bind_dn = node['formatron_grafana']['ldap_bind_dn']
ldap_bind_password = node['formatron_grafana']['ldap_bind_password']
ldap_uid = node['formatron_grafana']['ldap_uid']
ldap_first_name_attr = node['formatron_grafana']['ldap_first_name_attr']
ldap_last_name_attr = node['formatron_grafana']['ldap_last_name_attr']
ldap_member_of_attr = node['formatron_grafana']['ldap_member_of_attr']
ldap_email_attr = node['formatron_grafana']['ldap_email_attr']
ldap_admin_group_dn = node['formatron_grafana']['ldap_admin_group_dn']
ldap_editor_group_dn = node['formatron_grafana']['ldap_editor_group_dn']

include_recipe 'database::postgresql'

postgresql_connection_info = {
  host: database_host,
  port: database_port,
  username: postgres_user,
  password: postgres_password
}

postgresql_connection_info_graphite = {
  host: database_host,
  port: database_port,
  username: database_user,
  password: database_password
}

postgresql_database_user database_user do
  connection postgresql_connection_info
  password database_password
  createdb true
  action :create
end

postgresql_database database_name do
  connection postgresql_connection_info_graphite
  action :create
end

apt_repository 'grafana' do
  uri 'https://packagecloud.io/grafana/stable/debian/'
  distribution 'wheezy'
  components ['main']
  key 'https://packagecloud.io/gpg.key'
end

package 'grafana'

unless ldap_server.nil?
  template '/etc/grafana/ldap.toml' do
    variables(
      ldap_server: ldap_server,
      ldap_port: ldap_port,
      ldap_search_base: ldap_search_base,
      ldap_bind_dn: ldap_bind_dn,
      ldap_bind_password: ldap_bind_password,
      ldap_uid: ldap_uid,
      ldap_first_name_attr: ldap_first_name_attr,
      ldap_last_name_attr: ldap_last_name_attr,
      ldap_member_of_attr: ldap_member_of_attr,
      ldap_email_attr: ldap_email_attr,
      ldap_admin_group_dn: ldap_admin_group_dn,
      ldap_editor_group_dn: ldap_editor_group_dn
    )
  end
end

template '/etc/grafana/grafana.ini' do
  group 'grafana'
  variables(
    use_ldap: !ldap_server.nil?,
    admin_user: admin_user,
    admin_password: admin_password,
    host: database_host,
    port: database_port,
    name: database_name,
    user: database_user,
    password: database_password
  )
  notifies :restart, 'service[grafana-server]', :delayed
end

service 'grafana-server' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
