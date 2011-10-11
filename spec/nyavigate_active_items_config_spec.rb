require 'config_spec_helper'

describe 'Nyavi active items config' do
  # A menu item can be configured as active for a specific action
  # YAML file eg:
  # -------------
  # controller_name:
  #   action: menu_item_1
  describe "active item configuration" do
    before(:each) do
      @menu = Nyavi::Menu.new(:controller_wide_menu, controller)
    end

    it "returns all menu items regardless of the action" do
      @menu.active_item.should == 'item_2'
    end
  end

  def controller
    mock('controller', :controller_name => 'accounts', :action_name => 'index')
  end
end
