require 'config_spec_helper'

describe 'Nyavi items config' do
  # A menu can be configured for all actions of a controller
  # YAML file eg:
  # -------------
  # controller_name:
  #   - menu_item_1: path
  #   - menu_item_2: path
  describe "controller wide configuration" do
    before(:each) do
      @menu = Nyavi::Menu.new(:controller_wide_menu, controller)
    end

    it "returns all menu items regardless of the action" do
      @menu.items.collect(&:name).should == ['item_1', 'item_2']
    end
  end

  # A menu can be configured for a specific action of a controller
  # YAML file eg:
  # -------------
  # controller_name:
  #   action_name:
  #     - menu_item_1: path
  #     - menu_item_2: path
  describe "action specific configuration" do
    before(:each) do
      @menu = Nyavi::Menu.new(:action_specific_menu, controller)
    end

    it "returns only the menu items configured for the current action" do
      @menu.items.collect(&:name).should == ['item_1', 'item_2']
    end
  end

  # A menu item can be defined with a condition
  # YAML file eg:
  # controller_name:
  #   - menu_item_1:
  #       target: path
  #       condition: current_user.is_superuser?
  describe "conditional menu item configuration" do
    before(:each) do
      @menu = Nyavi::Menu.new(:conditional_items_menu, controller)
    end

    it "does not return the menu item when the condition fails" do
      @menu.items.collect(&:name).should_not include('item_2')
    end

    it "returns the menu item when the condition passes" do
      @menu.items.collect(&:name).should include('item_1')
    end
  end

  def controller
    mock('controller', :controller_name => 'accounts', :action_name => 'index')
  end
end
