module Simpler
  class ParamsGrabber
    def initialize(env)
      @env = env['PATH_INFO']
    end

    def grabber
      arr = @env.split('/')
      { id: arr[2].to_i }
    end
  end
end
