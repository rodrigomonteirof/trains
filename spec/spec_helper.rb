$LOAD_PATH.unshift(File.dirname(__FILE__), '..')
require 'rspec'
require 'byebug'

require './app/models/map'
require './app/models/route'
require './app/routers/router'
require './app/routers/dijkstra_router'
require './app/routers/simple_router'

RSpec.configure do |config|
  config.order = 'random'
end
