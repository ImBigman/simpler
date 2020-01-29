class TestsController < Simpler::Controller
  def show
    @test = Test.find(params[:id])
    @params = params[:id]
  end

  def index
    @tests = Test.all
    # render plain: 'This is plain response!'
    # render inline: '<strong>This is inline response!</strong>'
    # render xml: 'This is xml response!'
    # render html: '<h1>This is html response!</h1>'
    # render json: 'This is json response!'
  end

  def create; end
end
