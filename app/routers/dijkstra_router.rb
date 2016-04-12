class DijkstraRouter < Router

  def find_path(origin, destiny, check_loop = true)
    @available_routes = []

    load_routes(origin)

    shortest_path(origin, destiny, check_loop)
  end

  private

  def shortest_path(origin, destiny, check_loop)
    route = shortest_route
    return 'NO SUCH ROUTE' if route.nil?

    if check_loop and loop?(route)
      delete_route(route)
      route = shortest_path(origin, destiny, check_loop)
    end

    # delete parent from @@available_routes
    delete_route(route)

    # merge the children
    # ex: (A-B) search all children of B and return (a-B-c and a-B-d)
    load_routes(route.destiny, route)

    #recursivity if is not on destiny
    route = shortest_path(origin, destiny, check_loop) if route.destiny != destiny

    route
  end

  def loop?(place)
    place.origin.split('-')[0...-1].include? place.destiny
  end

end
