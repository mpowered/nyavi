class Nyavigator
  def initialize(menu_name, controller_name, action_name)
    @menu_name = menu_name
    @controller_name = controller_name
    @action_name = action_name
  end

  def items
    return if menu_items.nil?
    yield menu_items, active_item
  end

  private
  def menu_items
    @menu_items ||= get_value(controller_menu_items_config)
  end

  def active_item
    @active_item ||= get_value(controller_active_item_config)
  end

  def get_value(config)
    # Support for following format in yml:
    # controller: active_item
    # or
    # controller:
    #  action: active_item
    config.is_a?(Hash) ? config[@action_name] : config
  end

  def controller_menu_items_config
    @menu_items_config ||= load_from_file(@menu_name)[@controller_name]
  end

  def controller_active_item_config
    @active_items_config ||= load_from_file(@menu_name, 'active_items')[@controller_name]
  end

  def load_from_file(menu_name, file = 'items')
    YAML::load_file(File.join(RAILS_ROOT,"/config/#{menu_name}/#{file}.yml"))
  end
end
