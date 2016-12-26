require 'json'

class Silex
  def initialize
    @callbacks = {}
  end

  # maybe use delegate
  def get(uri, &callback)
    add_route(uri, callback, 'GET')
  end

  # receive a block
  # how to pass a block to a method and retrieve it inside the method?
  def post(uri, &callback)
    add_route(uri, callback, 'POST')
  end

  # receive a block
  # how to pass a block to a method and retrieve it inside the method?
  def add_route(uri, callback, http_method)
    @callbacks[http_method] = { uri => callback }
  end

  # implements a rack interface
  def call(env)
    req = Rack::Request.new(env)
  end

  def init
    env = {
      request_method: 'GET',
      request_uri: '/lineup'
    }
    req = Request.new(env)
    request_uri    = req.request_uri
    request_method = req.request_method

    routes_uri = @callbacks[request_method]

    if routes_uri.has_key? request_uri
      requested_callback = @callbacks[request_method][request_uri]

      requested_callback.call
    else
      puts "Request not Found"
    end
  end
end

class Request
  attr_reader :request_method, :request_uri

  def initialize(env)
    @request_method = env[:request_method]
    @request_uri    = env[:request_uri]
  end
end

app = Silex.new

app.get '/lineup' do
  artists = [
    {'nome' => 'The Beatles'},
    {'nome' => 'U2'},
    {'nome' => 'Garbage'},
  ]

  #return artists.to_json # unexpected return (LocalJumpError)
  puts artists.to_json
end
# app.post '/lineup' do
# end

app.init
