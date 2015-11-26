actions :create
default_action :create

attribute :name, name_attribute: true, kind_of: String, required: true
attribute :type, kind_of: String, required: true
attribute :url, kind_of: String, required: true
attribute :access, kind_of: String, required: true
attribute :basic_auth, kind_of: [TrueClass, FalseClass], required: true
