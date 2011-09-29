class ContextBar
  def self.context(controller, &block)
    yield load_context(controller)
  end

  private
  def self.load_context(controller)
    YAML::load_file(File.join(RAILS_ROOT,"/config/context_bar/contexts.yml"))[controller]
  end
end