Nyavi
=====
Nyavi is an HTML navigation builder that uses YAML as a configuration DSL.

-------------
Views are arranged by controller and action in Nyavi. To specify a set of menu items for all the actions in a controller define them as follows in `config/name_of_menu/items.yml`:

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

To define which items must be marked as active in a particular context use the `config/name_of_menu/active_items.yml` configuration as follows:

    controller_name:
      action_name: item_1 # item_1 will be active in this instance

If more than one menu item that can be active within a specific action then you can specify the conditons as follows:

    controller_name:
      action_name:
        "params[:id] == 'scorecard'" : item_1
        "params[:id] == 'ownership'" : item_2

If you would like to have menu items dynamically generated then you can configure as follows:

    controller_name:
      dynamic_items:
        titles: A hash of key/values to translate titles
        links: A hash of key/values to map links to items
        items: current_scorecard.elements_as_symbols
      static_items:
        before:
          - item_1: path
        after:
          - item_2: path

The 'before' and 'after' keys in the 'static_items' you to set the position of the static items relative to the dynamic items.

Tricks
------
If the controller being used is nested, the controller_name does not include the parent levels - just the controller name based on the file.

Usage
-----
The menu is rendered as a UL with each menu item in its own LI tag. The active item has the class 'active' added to the LI. To render your menu simply call the following in your view:

    = nyavigate_the :name_of_menu

The configuration files must reside in `config/:name_of_menu`. You will need to create the two YAML files needed:
* items.yml
* active_items.yml

If you want to build your own HTML structure for the view you can pass in a block:

    - nyavigate_the :name_of_menu do |items, active_item|
      %ul
        - items.each do |item|
          %li{:class => (item.name == active_item ? 'active' : '' )}
            %a{:href => item.target}= item.name


Installation
------------

    gem "nyavi", :git => "git://github.com/mpowered/nyavi.git"

