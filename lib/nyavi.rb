module Nyavi
  module ViewHelpers
    def nyavigate_the(menu_name, &block)
      Nyavi::Menu.new(menu_name, controller, self).items_with_active do |items, active_item|
        if block_given?
          yield items, active_item
        else
          render :partial => 'nyavigate/menu_item.html.haml', :locals => {:items => items, :active_item => active_item, :menu_name => menu_name}
        end
      end
    end
  end
end

require 'nyavi/menu'
require 'nyavi/item'
require 'nyavi/exceptions/nyavi_active_items_config_error'
require 'nyavi/exceptions/nyavi_items_config_error'

ActionView::Base.send(:include, Nyavi::ViewHelpers)

# Rails 2 doesn't load view paths for Gems.
ActionController::Base.view_paths.concat(["#{`bundle show nyavi`.chomp}/app/views"]) if Rails.version.first.to_i < 3
