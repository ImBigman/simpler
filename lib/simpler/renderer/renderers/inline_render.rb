require 'erb'

class InlineRender
  attr_reader :header, :body
  def initialize(template)
    @template = template
    @header = 'text/html'
    @body = ERB.new(@template.values.join).result
  end
end
