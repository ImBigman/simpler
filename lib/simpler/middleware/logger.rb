require 'logger'
require_relative 'helper/logformatter'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    @logger.info([LogFormatter.new(env, @app).formatter].join(' '))
    @app.call(env)
  end
end
