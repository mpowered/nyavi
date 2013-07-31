module NyaviHelper
  def nyavigate_the(menu_name, &block)
    Nyavi::Menu.new(menu_name, controller, self).items_with_active do |items, active_item|
      if block_given?
        yield items, active_item
      else
        render :partial => 'nyavigate/menu_item', :locals => {:items => items, :active_item => active_item, :menu_name => menu_name}
      end
    end
  end
end
