class Nyavi::Menu
  attr_reader :controller, :template_binding, :menu_name, :controller_name, :action_name

  def initialize(menu_name, controller)
    @menu_name = menu_name
    @controller = controller
    @controller_name = controller.controller_name
    @action_name = controller.action_name
    @template_binding = controller.instance_variable_get(:@template).send(:binding)
  end

  def items_with_active
    return if menu_items.nil?
    yield items, active_item
  end

  # Returns all allowed menu items wrapped as Nyavi::Items
  def items
    @items ||= menu_items.map{|i| Nyavi::Item.new(i, self)}.select(&:allowed?)
  end

  # Returns the name of the active menu item
  def active_item
    return @active_item if @active_item
    # Simple configuration means that name is returned immediately
    @active_item = get_value(controller_active_item_config)

    # If the configuration is a Hash then we need to find the first
    # menu item that has a passing condition
    if @active_item.is_a? Hash
      @active_item.each do |condition, key|
        @active_item = key and break if eval(condition, @template_binding)
      end
    end
    @active_item
  end

  private
  def menu_items
    @menu_items ||= get_value(controller_menu_items_config)
  end

  def get_value(config)
    # A proc used later to extract config
    extract_dynamic_and_static_items = Proc.new do |config, template_binding| 
      # Get all the items from the dynamic method
      items = eval(config['dynamic_items']['items'], template_binding).map(&:to_s) 
      # Group dynamic items with their titles and their targets
      items = items.collect do |item| 
        target = config['dynamic_items']['links'][item]
        raise NyaviItemsConfigError, "Dynamic menu item :#{item} missing its link definition in config/#{menu_name}/items.yml under controller :#{controller_name}" if target.nil?
        {config['dynamic_items']['titles'][item] => target}
      end
      # Add any 'before' static items
      items = config['static_items']['before'] + items if config['static_items'] && config['static_items'].has_key?('before')
      # Add any 'after' static items
      items = items + config['static_items']['after'] if config['static_items'] && config['static_items'].has_key?('after') 
      items
    end

    # If the config is a Hash then
    # 1 - It could mean that the options are nested in an 'action_name'
    # 2 - Or that the menu is configured to deliver 'dynamic_items' across all actions
    if config.is_a?(Hash)
      # Case 2 above 
      if config.keys.include?('dynamic_items')
        extract_dynamic_and_static_items.call(config, @template_binding)

      # Case 1 above
      else
        # If the options within the 'action_name' are a Hash including 'dynamic_items'
        # then the config is for dynamic items
        if config[@action_name].is_a?(Hash) && config[@action_name].keys.include?('dynamic_items')
        extract_dynamic_and_static_items.call(config[@action_name], @template_binding)

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
