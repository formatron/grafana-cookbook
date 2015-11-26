default['formatron_grafana']['admin']['user'] = 'admin'
default['formatron_grafana']['admin']['password'] = 'changeme'
default['formatron_grafana']['postgresql']['user'] = 'postgres'
default['formatron_grafana']['postgresql']['password'] = 'changeme'
default['formatron_grafana']['database']['host'] = 'localhost'
default['formatron_grafana']['database']['port'] = 5432
default['formatron_grafana']['database']['name'] = 'grafana'
default['formatron_grafana']['database']['user'] = 'grafana'
default['formatron_grafana']['database']['password'] = 'changeme'

# if ldap_server is nil then LDAP will not be used
default['formatron_grafana']['ldap_server'] = nil
default['formatron_grafana']['ldap_port'] = nil
default['formatron_grafana']['ldap_search_base'] = nil
default['formatron_grafana']['ldap_bind_dn'] = nil
default['formatron_grafana']['ldap_bind_password'] = nil
default['formatron_grafana']['ldap_uid'] = 'uid'
default['formatron_grafana']['ldap_first_name_attr'] = 'givenName'
default['formatron_grafana']['ldap_last_name_attr'] = 'sn'
default['formatron_grafana']['ldap_member_of_attr'] = 'memberOf'
default['formatron_grafana']['ldap_email_attr'] = 'mail'
default['formatron_grafana']['ldap_admin_group_dn'] = nil
default['formatron_grafana']['ldap_editor_group_dn'] = nil
