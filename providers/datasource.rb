def whyrun_supported?
  true
end

use_inline_resources

class JSONHTTP < Chef::HTTP
  self.use Chef::HTTP::JSONInput
  self.use Chef::HTTP::JSONOutput
end

action :create do
  name = new_resource.name
  type = new_resource.type
  url = new_resource.url
  access = new_resource.access
  basic_auth = new_resource.basic_auth
  basic_auth_user = new_resource.user
  basic_auth_password = new_resource.password
  username = node['formatron_grafana']['admin']['user']
  password = node['formatron_grafana']['admin']['password']
  api = JSONHTTP.new "http://#{username}:#{password}@localhost:3000/api"
  datasources = api.get 'datasources'
  datasource_index = datasources.index { |entry| entry['name'].eql? name }
  if datasource_index.nil?
    new_datasource = {
      name: name,
      type: type,
      url: url,
      access: access,
      basicAuth: basic_auth
    }
    new_datasource['basicAuthUser'] = basic_auth_user unless basic_auth_user.nil?
    new_datasource['basicAuthPassword'] = basic_auth_password unless basic_auth_password.nil?
    api.post(
      'datasources',
      new_datasource
    )
    new_resource.updated_by_last_action true
  else
    datasource = datasources[datasource_index]
    fail "#{datasource['name']} - #{datasource['id']}"
    new_datasource = datasource.clone
    new_datasource['type'] = type
    new_datasource['url'] = url
    new_datasource['access'] = access
    new_datasource['basicAuth'] = basic_auth
    new_datasource['basicAuthUser'] = basic_auth_user unless basic_auth_user.nil?
    new_datasource['basicAuthPassword'] = basic_auth_password unless basic_auth_password.nil?
    unless datasource == new_datasource
      api.post(
        "datasources/#{datasource['id']}",
        new_datasource
      )
      new_resource.updated_by_last_action true
    end
  end
end
