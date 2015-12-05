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

formatron_grafana_dashboard 'just testing' do
  model(
    'tags' => [],
    'style' => 'light',
    'timezone' => 'browser',
    'editable' => true,
    'hideControls' => false,
    'sharedCrosshair' => false,
    'rows' => [
      {
        'collapse' => false,
        'editable' => true,
        'height' => '250px',
        'panels' => [
          {
            'aliasColors' => {},
            'bars' => false,
            'datasource' => nil,
            'editable' => true,
            'error' => false,
            'fill' => 1,
            'grid' => {
              'leftLogBase' => 1,
              'leftMax' => nil,
              'leftMin' => nil,
              'rightLogBase' => 1,
              'rightMax' => nil,
              'rightMin' => nil,
              'threshold1' => nil,
              'threshold1Color' => 'rgba(216, 200, 27, 0.27)',
              'threshold2' => nil,
              'threshold2Color' => 'rgba(234, 112, 112, 0.22)'
            },
            'id' => 1,
            'legend' => {
              'avg' => false,
              'current' => false,
              'max' => false,
              'min' => false,
              'show' => true,
              'total' => false,
              'values' => false
            },
            'lines' => true,
            'linewidth' => 2,
            'links' => [],
            'nilPointMode' => 'connected',
            'percentage' => false,
            'pointradius' => 5,
            'points' => false,
            'renderer' => 'flot',
            'seriesOverrides' => [],
            'span' => 12,
            'stack' => false,
            'steppedLine' => false,
            'targets' => [
              {
                'refId' => 'A'
              }
            ],
            'timeFrom' => nil,
            'timeShift' => nil,
            'title' => 'Test',
            'tooltip' => {
              'shared' => true,
              'value_type' => 'cumulative'
            },
            'type' => 'graph',
            'x-axis' => true,
            'y-axis' => true,
            'y_formats' => [
              'short',
              'short'
            ]
          }
        ],
        'title' => 'Row'
      }
    ],
    'time' => {
      'from' => 'now-6h',
      'to' => 'now'
    },
    'timepicker' => {
      'refresh_intervals' => [
        '5s',
        '10s',
        '30s',
        '1m',
        '5m',
        '15m',
        '30m',
        '1h',
        '2h',
        '1d'
      ],
      'time_options' => [
        '5m',
        '15m',
        '1h',
        '6h',
        '12h',
        '24h',
        '2d',
        '7d',
        '30d'
      ]
    },
    'templating' => {
      'list' => []
    },
    'annotations' => {
      'list' => []
    },
    'schemaVersion' => 7,
    'links' => []
    )
end
