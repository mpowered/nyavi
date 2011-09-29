class MenuBar
  private
  def self.load_items(controller, action)
    items = YAML::load_file(File.join(RAILS_ROOT,"/config/#{self.name.underscore}/items.yml"))[controller]
    get_value(items, action)
  end

  def self.load_active_item(controller, action)
    active_item_config = YAML::load_file(File.join(RAILS_ROOT,"/config/#{self.name.underscore}/active_items.yml"))[controller]
    get_value(active_item_config, action)
  end

  def self.get_value(config, action)
    # Support for following format in yml:
    # controller: active_item
    # or
    # controller:
    #  action: active_item
    config.is_a?(Hash) ? config[action] : config
  end
end