class Nyavi::Item
  attr_reader :name

  def initialize(raw_item, menu)
    @name = raw_item.keys.first
    @config = raw_item.values.first
    @menu = menu
  end

  def target
    @target = compact_config? ? @config : @config['target']
    raise NyaviItemsConfigError, "Menu item '#{@name}' missing its target in config/#{@menu.menu_name}/items.yml under controller :#{@menu.controller_name}" if @target.nil?
    @target.include?('#') ? @target : @menu.template.instance_eval(@target)
  end

  def allowed?
    return true if compact_config?
    @allowed ||= @config['condition'].is_a?(String) ? @menu.template.instance_eval(@config['condition']) : @config['condition']
  end

  private
  def compact_config?
    @compact_config ||= !@config.is_a?(Hash)
  end
end
