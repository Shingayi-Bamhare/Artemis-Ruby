unless defined?(Motion::Project::Config)
  require 'helpers/class_level_inheritable_attributes'
  require 'artemis/entity_observer'
  require 'artemis/manager'

  require "artemis/entity"
  require "artemis/component"
  require "artemis/component_type"
  require 'artemis/component_mapper'
  require 'artemis/component_manager'
  require "artemis/aspect"

  require 'artemis/bag'
  require 'artemis/world'
  require 'artemis/entity_manager'
  require 'artemis/group_manager'
  require 'artemis/tag_manager'

  require 'artemis/aspect'

  require 'artemis/entity_system'

  puts "Required artemis"
else
  Motion::Project::App.setup do |app|
    Dir.glob(File.join(File.dirname(__FILE__), 'artemis/*.rb')).each do |file|
      app.files.unshift(file)
    end
  end
end
