# This spec helper loads up only the Nyavi::Item and Nyavi::Menu classes.
# The ActionView::Base extensions won't be loaded

module Nyavi;end

Rails.root = `pwd`.chomp + '/spec/assets/'

require 'nyavi/menu'
require 'nyavi/item'
