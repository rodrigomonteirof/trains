class FullscanRouter < Router

  attr_accessor(:routes)

  def load_default(origin)
    @available_routes = []
    @routes = []

    load_routes(origin)
  end

  def find_path_with_stops(origin, destiny, limit = 5)
    load_default(origin)
    fullscan_with_stops(origin, destiny, limit)
  end

  def find_path_with_distance(origin, destiny, distance)
    load_default(origin)
    fullscan_with_distance(origin, destiny, distance = 30)
  end

  def fullscan_with_stops(origin, destiny, limit)
    @available_routes.delete_if{ |r| r.stops > limit }

    scan_routes(destiny)

    fullscan_with_stops(origin, destiny, limit) unless @available_routes.empty?

    @routes
  end

  def fullscan_with_distance(origin, destiny, distance)
    @available_routes.delete_if{ |r| r.distance >= distance }

    scan_routes(destiny)

    fullscan_with_distance(origin, destiny, distance) unless @available_routes.empty?

    @routes
  end

  def scan_routes(destiny)
    route = @available_routes.first

    @routes << route if !route.nil? and route.destiny == destiny

    delete_route(route)

    load_routes(route.destiny, route) unless route.nil?
  end

end
