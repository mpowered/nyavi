module Nyavi
  class Railtie < Rails::Railtie
    initializer 'brighter_planet_layout.add_paths' do |app|
      app.paths.app.views.push (`bundle show nyavi`.chomp + '/app/views')
    end

  end
end
