class LogFormatter
  HEADERS = ['Request:', 'Handler:', 'Parameters:', 'Response:'].freeze

  def initialize(env, app)
    @env = env
    @app = app
    @request = Rack::Request.new(@env)
    @code = Rack::Utils::HTTP_STATUS_CODES
  end

  def formatter
    status, headers = @app.call(@env)
    req = "\n #{HEADERS[0]} #{@env['REQUEST_METHOD']}  #{@env['REQUEST_URI']}\n"
    han = "#{HEADERS[1]} #{controller_name(@request.env['simpler.controller'])}##{@request.env['simpler.action']} \n"
    par = "#{HEADERS[2]} #{@request.params}\n"
    res = "#{HEADERS[3]} #{status} #{@code[status]} #{[headers['Content-Type']]} #{template_path} \n"
    [req, han, par, res].join(' ')
  end

  def controller_name(obj)
    arr = obj.to_s.split(':')
    arr[0][2..-1]
  end

  def template_path
    arr = [@request.env['simpler.controller'].name, @request.env['simpler.action']].join('/')
    arr + '.html.erb'
  end
end
