class PlainRender
  attr_reader :header, :body
  def initialize(template)
    @template = template
    @header = 'text/plain'
    @body = @template.values.join
  end
end
