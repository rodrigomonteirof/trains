class Map

  attr_accessor(:routes)

  def initialize(routes)
    @routes = routes
  end

  def find_routes(origin)
    routes.select { |r| r.origin == origin }
  end

  def find_route(origin, destiny)
    routes.select { |r| r.origin == origin and r.destiny == destiny }.first
  end

end
