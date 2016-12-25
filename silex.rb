class Silex
  def initialize
    @@callbacks = []
  end

  # maybe use delegate
  def get(uri, callback)
    add_route(uri, callback)
  end

  # receive a block
  # how to pass a block to a method and retrieve it inside the method?
  def post(uri, callback)
    add_route(uri, callback)
  end

  # receive a block
  # how to pass a block to a method and retrieve it inside the method?
  def add_route(uri, callback)
    @@callbacks << { uri: callback }
  end
end

app = Silex.new

app.post '/lineup' do
end

app.get '/lineup' do
end
