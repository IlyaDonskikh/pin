class SinatraTest < Sinatra::Base
  get '/' do
    content_type :json

    "Hello, world!1"
  end
end
