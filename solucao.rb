require './app/models/map'
require './app/models/route'
require './app/routers/router'
require './app/routers/dijkstra_router'
require './app/routers/simple_router'
require './app/routers/fullscan_router'

file = File.open(ARGV[0], "r")
content = File.read(file)

routes = []

content.split(',').each do |route|
  route = route.strip
  routes << Route.new(route[0], route[1], route[2..-1].to_i)
end

map = Map.new(routes)

dijkstra = DijkstraRouter.new(map)
full = FullscanRouter.new(map)
simple = SimpleRouter.new(map)

puts "Output #1: #{simple.find_path('A-B-C').to_s}"
puts "Output #2: #{simple.find_path('A-D').to_s}"
puts "Output #3: #{simple.find_path('A-D-C').to_s}"
puts "Output #4: #{simple.find_path('A-E-B-C-D').to_s}"
puts "Output #5: #{simple.find_path('A-E-D').to_s}"
puts "Output #6: #{full.find_path_with_stops('C','C', 3).count}"
puts "Output #7: #{full.find_path_with_stops('C','C', 4).select{|r| r.stops == 4}.count}"
puts "Output #8: #{dijkstra.find_path('A','C').distance}"
puts "Output #9: #{dijkstra.find_path('B','B', false).distance}"
puts "Output #10: #{full.find_path_with_distance('C','C', 30).count}"
