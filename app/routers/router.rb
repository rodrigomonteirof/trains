class Router

  attr_accessor(:map, :available_routes)

  def initialize(map)
    @map = map
    @available_routes = []
  end

  def load_routes(place, parent = nil)
    routes = @map.find_routes(place)

    unless parent.nil?
      routes = merge_routes(routes, parent)
    end

    @available_routes << routes
    @available_routes.flatten!
  end

  def shortest_route
    @available_routes.flatten.sort_by{ |s| s.distance }.first
  end

  def delete_route(route)
    @available_routes.delete(route)
  end

  def merge_routes(routes, parent)
    new_routes = []

    routes.each do |route|
      new_routes << Route.new(
        "#{parent.origin}-#{route.origin}",
        route.destiny,
        parent.distance + route.distance
      )
    end

    new_routes.flatten
  end

end
