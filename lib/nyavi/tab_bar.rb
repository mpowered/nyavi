class TabBar < MenuBar
  def self.tabs(controller, action, &block)
    tabs = load_items(controller, action)
    return if tabs.nil?
    active_tab = load_active_item(controller, action)
    yield tabs, active_tab
  end
end