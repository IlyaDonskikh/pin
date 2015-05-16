module WheelyPin
  class Application < Sinatra::Base
    get '/create/?' do
      generate_pin = Pin::Create.call(params[:token])

      generate_pin.to_json
    end

    get '/show/?' do
      pin = Pin.find('228')

      pin.code.to_json
    end
  end
end
