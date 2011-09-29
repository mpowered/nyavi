class ToolBar < MenuBar
  def self.actions(controller, action, &block)
    yield load_items(controller, action)
  end
end