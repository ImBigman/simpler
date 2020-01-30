require_relative 'renderers/plain_render'
require_relative 'renderers/json_render'
require_relative 'renderers/inline_render'
require_relative 'renderers/xml_render'
require_relative 'renderers/html_render'

module Simpler
  class Renderer
    def initialize(template)
      @template = template
    end

    def call
      result = Object.const_get("#{@template.keys.join.capitalize}Render")
      result.new(@template)
    end
  end
end
