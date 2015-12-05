def whyrun_supported?
  true
end

use_inline_resources

class JSONHTTP < Chef::HTTP
  self.use Chef::HTTP::JSONInput
  self.use Chef::HTTP::JSONOutput
end

def get_dashboard(api, name)
  # late require to allow installation of gem first
  require 'active_support/core_ext/string/inflections'
  slug = name.parameterize
  response = api.get "dashboards/db/#{slug}"
  response['dashboard']
rescue
  nil
end

action :create do
  name = new_resource.name
  model = new_resource.model
  username = node['formatron_grafana']['admin']['user']
  password = node['formatron_grafana']['admin']['password']
  api = JSONHTTP.new "http://#{username}:#{password}@localhost:3000/api"
  dashboard = get_dashboard api, name
  new_dashboard = model.clone
  new_dashboard['title'] = name
  new_dashboard['originalTitle'] = name
  if dashboard.nil?
    new_dashboard['id'] = nil
    new_dashboard['version'] = 0
    api.post(
      'dashboards/db',
      dashboard: new_dashboard,
      overwrite: false
    )
    new_resource.updated_by_last_action true
  else
    new_dashboard['id'] = dashboard['id']
    new_dashboard['version'] = dashboard['version']
    unless dashboard == new_dashboard
      api.post(
        'dashboards/db',
        dashboard: new_dashboard,
        overwrite: true
      )
      new_resource.updated_by_last_action true
    end
  end
end
