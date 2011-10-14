class Nyavi::Item
  attr_reader :name

  def initialize(raw_item, menu)
    @name = raw_item.keys.first
    @config = raw_item.values.first
    @menu = menu
    @template_binding = @menu.template_binding
  end

  def target
    @target = compact_config? ? @config : @config['target']
    @target.include?('#') ? @target : eval(@target, @template_binding)
  end

  def allowed?
    return true if compact_config?
    @allowed ||= @config['condition'].is_a?(String) ? eval(@config['condition'], @template_binding) : @config['condition']
    @allowed
  end

  private
  def compact_config?
    @compact_config ||= @config['target'].nil?
  end
end
