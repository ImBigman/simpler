require 'active_support/core_ext'

class XmlRender
  attr_reader :header, :body
  def initialize(template)
    @template = template
    @header = 'text/xml'
    @body = @template.to_xml
  end
end
