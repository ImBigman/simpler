require 'erb'

class HtmlRender
  attr_reader :header, :body
  def initialize(template)
    @template = template
    @header = 'text/html'
    @body = @template.values.join.html_safe
  end
end
