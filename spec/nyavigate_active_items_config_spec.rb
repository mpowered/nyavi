require 'config_spec_helper'

describe 'Nyavi active items config' do
  # A menu item can be configured as active for a specific action
  # YAML file eg:
  # -------------
  # controller_name:
  #   action: menu_item_1
  describe "action wide configuration" do
    before(:each) do
      @menu = Nyavi::Menu.new(:controller_wide_menu, controller)
    end

    it "returns the menu item specified for the current action" do
      @menu.active_item.should == 'item_2'
    end
  end

  # A menu item can be canfigured as active under specific conditions within an action
  # YAML file eg:
  # -------------
  # controller_name:
  #   action:
  #     "params[:id] == 'scorecard'" : menu_item_1
  describe "conditonal configuration" do
    before(:each) do
      @menu = Nyavi::Menu.new(:action_specific_menu, controller)
    end

    it "returns the first menu item that has a passing condition for the current action" do
      @menu.active_item.should == 'item_3'
    end
  end

  def controller
    mock('controller', :controller_name => 'accounts', :action_name => 'index')
  end
end
