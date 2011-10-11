#module ActionView
#  class Base
#  end
#end
#
#class Rails
#  def self.version
#    '2.3.5'
#  end
#end
#
#module ActionController
#  class Base
#    def self.view_paths
#      []
#    end
#  end
#end

require 'active_ksupport'
require 'actionpack'

RAILS_ROOT = `pwd`.chomp + '/spec/assets'

require 'nyavi'

describe 'Nyavigate menu' do
  before(:each) do
    @template = ActionView::Base.new
    @template.stub(:controller).and_return(mock('controller', :controller_name => 'accounts', :action_name => 'index'))
    @template.nyavigate_the :whole_controller
  end
  # A menu can be configured for all actions of a controller
  # YAML file eg:
  # -------------
  # controller_name:
  #   - menu_item_1: path
  #   - menu_item_2: path
  describe "a menu that is configured for an entire controller" do
    it "displays all menu items regardless of the action" do
      pending
    end
  end

  # A menu can be configured for a specific action of a controller
  # YAML file eg:
  # -------------
  # controller_name:
  #   action_name:
  #     - menu_item_1: path
  #     - menu_item_2: path
  describe "a menu that is configured for a specific action of a controller" do
    it "displays only the menu items configured for the current action" do
      pending
    end
  end
end

describe 'Nyavigate menu item' do
  # A menu item can be defined simply
  # YAML file eg:
  # controller_name:
  #   - menu_item_1: path
  describe "a menu item with only the target defined" do
    it "displays the menu item with an onclick trigger to go to the target" do
      pending
    end
  end

  # A menu item can be defined with a condition
  # YAML file eg:
  # controller_name:
  #   - menu_item_1:
  #       target: path
  #       condition: current_user.is_superuser?
  describe "a menu item that is conditional" do
    it "does not display the menu item when the condition fails" do
      pending
    end

    it "displays the menu item when the condition passes" do
      pending
    end
  end
end
