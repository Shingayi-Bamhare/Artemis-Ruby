if defined?(Motion::Project::Config)
  Motion::Project::App.setup do |app|
    Dir.glob(File.join(File.dirname(__FILE__), 'artemis/*.rb')).each do |file|
      puts file
      app.files.unshift(file)
    end
  end
else
  require 'artemis/entity_observer'
  require 'artemis/manager'

  require 'artemis/entity'
  require 'artemis/component'
  require 'artemis/component_type'
  require 'artemis/component_mapper'
  require 'artemis/component_manager'
  require 'artemis/aspect'

  require 'artemis/bag'
  require 'artemis/world'
  require 'artemis/entity_manager'
  require 'artemis/group_manager'
  require 'artemis/tag_manager'

  require 'artemis/aspect'

  require 'artemis/entity_system'
  require 'artemis/entity_processing_system'
end