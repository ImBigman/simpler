require 'erb'

module Simpler
  class View
    VIEWS_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def template
      @env['simpler.template']
    end

    def action
      @env['simpler.action']
    end

    def template_path
      path = template || [controller.name, action].join('/')
      Simpler.root.join(VIEWS_BASE_PATH, "#{path}.html.erb")
    end
  end
end
