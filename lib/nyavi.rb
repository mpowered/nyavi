require 'nyavi/exceptions/all'

module Nyavi
  class Engine < Rails::Engine
    # Add a load path for this specific Engine
    config.autoload_paths << File.expand_path("../", __FILE__)
  end
end
