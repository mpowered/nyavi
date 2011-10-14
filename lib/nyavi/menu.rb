class Nyavi::Menu
  attr_reader :controller, :template_binding

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
