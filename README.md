Nyavi
=====
Nyavi is a navigation builder. Configure the menu items you want available in different contexts and nyavi will build the view for you. Nyavi uses YAML as a configuration DSL.

Configuration
-------------
Views are arranged by controller in Nyavi. To specify a set of menu items for all the actions an a controller define them as follows:
    # In config/name_of_menu/items.yml
    controller_name:
      - item_1: path
      - item_2: path
      - item_3: path

To configure menu items for a specific action you simply include the action name:
    # In config/name_of_menu/items.yml
    controller_name:
      action_name:
        - item_1: path
        - item_2: path
        - item_3: path

To define menu items as conditional simply add the condition to the config. All conditions are run in context of the view, so you can use your view helpers:
    # In config/name_of_menu/items.yml
    controller_name:
      action_name:
        - item_1:
            target: path
            condition: current_user.is_superuser?

To define which items must be marked as active in a particular context you can use the active_items.yml file:
    # In config/name_of_menu/active_items.yml
    controller_name:
      action_name: item_1 # item_1 will be active in this instance

Usage
-----
The menu is rendered as a plain UL with each menu item in its own LI tag. The active item has the class 'active' added to the LI. To render your menu simply call:
    # In a view like app/views/application.html.haml
    = nyavigate_the :name_of_menu

If you want to build your own HTML structure for the view you can pass in a block:
    # In a view like app/views/application.html.haml
    - nyavigate_the :name_of_menu do |items, active_item|
      %ul
        = render :partial => 'your_custom_menu_item', :collection => items, :locals => {:active_item => active_item}
