Nyavi
=====
Nyavi is an HTML navigation builder that uses YAML as a configuration DSL.

-------------
Views are arranged by controller and action in Nyavi. To specify a set of menu items for all the actions an a controller define them as follows in `config/name_of_menu/items.yml`:

    controller_name:
      - item_1: path
      - item_2: path
      - item_3: path

To configure menu items for a specific action you simply include the action name in `config/name_of_menu/items.yml`:

    controller_name:
      action_name:
        - item_1: path
        - item_2: path
        - item_3: path

Add a condition to the config to mark menu items as conditional. All conditions are run in context of the view, so you can use your view helpers in `config/name_of_menu/items.yml`:

    controller_name:
      action_name:
        - item_1:
            target: path
            condition: current_user.is_superuser?

To define which items must be marked as active in a particular context us the `config/name_of_menu/active_items.yml` configuration as follows:

    controller_name:
      action_name: item_1 # item_1 will be active in this instance

Usage
-----
The menu is rendered as a UL with each menu item in its own LI tag. The active item has the class 'active' added to the LI. To render your menu simply call the following in your view:

    = nyavigate_the :name_of_menu

If you want to build your own HTML structure for the view you can pass in a block:

    - nyavigate_the :name_of_menu do |items, active_item|
      %ul
        = render :partial => 'your_custom_menu_item', :collection => items, :locals => {:active_item => active_item}

