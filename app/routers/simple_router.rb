class SimpleRouter < Router

  attr_accessor(:steps)

  def find_path(path)
    @available_routes = []

    load_steps(path)

    (steps.count - 1).times do |c|
      route = map.find_route(steps[c], steps[c+1])
      return 'NO SUCH ROUTE' if route.nil?

      if c == 0
        @available_routes << route
      else
        parent = @available_routes.first
        @available_routes << merge_routes([route], parent)
      end

      @available_routes.flatten!

      delete_route(parent) if @available_routes.count > 1
    end

    @available_routes.first
  end

  def load_steps(path)
    @steps = path.split('-')
  end
end
