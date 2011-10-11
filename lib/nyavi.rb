module Nyavi
  module ViewHelpers
    def nyavigate_the(menu_name, &block)
      Nyavi::Loader.new(menu_name, controller).items do |items, active_item|
        if block_given?
          yield tabs, active_tab
        else
          render :partial => 'nyavigate/menu_item.html.haml', :locals => {:items => items, :active_item => active_item}
        end
      end
    end
  end
end

require 'nyavi/loader'
require 'nyavi/item'

ActionView::Base.send(:include, Nyavi::ViewHelpers)

# Rails 2 doesn't load view paths for Gems.
ActionController::Base.view_paths.concat(["#{`bundle show nyavi`.chomp}/app/views"]) if Rails.version.first.to_i < 3
