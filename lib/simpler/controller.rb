require_relative 'view'
require_relative 'typeformatter/typeformatter'
module Simpler
  class Controller
    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      @request.env['simpler.resource'] = grabber(@request.env)
      # response_status(201)
      set_default_headers
      send(action)
      write_response
      @response.finish
    end

    private

    def params
      @request.env['simpler.resource']
    end

    def grabber(env)
      @env = env['PATH_INFO']
      arr = @env.split('/')
      { id: arr[2].to_i }
    end

    def response_status(code)
      @response.status = code
    end

    def headers
      @response
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def create_default_body(template)
      @request.env['simpler.body'] = template
    end

    def create_special_body(template)
      searching = TypeFormatter.new(template)
      headers['Content-Type'] = searching.formatter[0]
      @request.env['simpler.body'] = searching.formatter[1]
    end

    def write_response
      body = @request.env['simpler.body'] || render_default_body
      @response.write(body)
    end

    def render_default_body
      View.new(@request.env).render(binding)
    end

    def render(template)
      template.is_a?(Hash) ? create_special_body(template) : create_default_body(template)
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end
  end
end
