$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'remunger/data'
require 'remunger/report'
require 'remunger/item'

require 'remunger/render'
require 'remunger/render/csv'
require 'remunger/render/html'
require 'remunger/render/sortable_html'
require 'remunger/render/text'

module Remunger
  VERSION = '0.1.0'
end
