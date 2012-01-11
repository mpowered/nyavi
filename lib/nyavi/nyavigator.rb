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
    # If the config is a Hash then
    # 1 - It could mean that the options are nested in an 'action_name'
    # 2 - Or that the menu is configured to deliver 'dynamic_items' across all actions
    if config.is_a?(Hash)
      # Case 2 above 
      if config.keys.include?('dynamic_items')
        
      # Case 1 above
      else
        # If the action_name nested config has 'dynamic_items' as a key then
        # it has action specific dynamic_items
        if config[@action_name].keys.include?('dynamic_items')


        # Otherwise it has regular items that are specific to an action
        else
          config[@action_name]
        end
      end

    # Otherwise the config is for controllerwide regular items
    else
      config
    end
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
