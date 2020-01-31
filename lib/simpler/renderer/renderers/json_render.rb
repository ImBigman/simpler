require 'active_support/json'

class JsonRender
  attr_reader :header, :body
  def initialize(template)
    @template = template
    @header = 'text/json'
    @body = @template.to_json
  end
end
