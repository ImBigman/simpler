require 'active_support/core_ext'
require 'erb'
require 'active_support/json'

module Simpler
  class TypeFormatter
    def initialize(template)
      @template = template
    end

    def formatter
      send "#{@template.keys.join}"
    end

    def plain
      ['text/plain', @template.values.join]
    end

    def json
      ['text/json', @template.to_json]
    end

    def inline
      ['text/html', ERB.new(@template.values.join).result]
    end

    def xml
      ['text/xml', @template.to_xml]
    end

    def html
      ['text/html', @template.values.join.html_safe]
    end
  end
end
