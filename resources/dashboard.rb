actions :create
default_action :create

attribute :name, name_attribute: true, kind_of: String, required: true
attribute :model, kind_of: Hash, required: true
