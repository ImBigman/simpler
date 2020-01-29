require_relative 'router/route'

module Simpler
  class Router
    def initialize
      @routes = []
    end

    def get(path, route_point)
      add_route(:get, path, route_point)
    end

    def post(path, route_point)
      add_route(:post, path, route_point)
    end

    def route_for(env)
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']
      params_from_string(path)[:id].nil? ? nil : path = create_resources_route(path)
      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, route_point)
      route_point = route_point.split('#')
      action = route_point[1]
      controller = controller_from_string(route_point[0])
      route = Route.new(method, path, controller, action)

      @routes.push(route)
    end

    def params_from_string(path)
      path_arr = path.split('/')
      { id: path_arr[2] }
    end

    def create_resources_route(path)
      path_arr = path.split('/')
      path_arr[2] = ':id'
      path_arr.join('/')
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller")
    end
  end
end
