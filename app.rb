module SinatraTest
  class Application < Sinatra::Base
    get '/' do
      content_type :json

      pin = Pin.new()

      pin.code.to_json
    end

    get '/create/?' do
      pin = Pin.new(token: 'time', code: '5567')
      pin.save
    end

    get '/show/?' do
      pin = Pin.find('time')

      pin.code.to_json
    end
  end
end
