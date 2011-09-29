module Nyavi
  module ViewHelpers
    def nyavigate_the(menu_name, &block)
      Nyavigator.new(menu_name, controller.controller_name, controller.action_name).items do |tabs, active_tab|
        if block_given?
          yield tabs, active_tab
        else
          render :partial => 'nyavigate/menu_item.html.haml'
        end
      end
    end
  end
end

require 'nyavi/nyavigator'
require 'nyavi/context_bar'

ActionView::Base.send(:include, Nyavi::ViewHelpers)
