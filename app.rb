module WheelyPin
  class Application < Sinatra::Base
    get '/create' do
      create_pin = Pin::Create.call(params[:token])

      create_pin.to_json
    end

    get '/check' do
      token = params[:token]
      code = params[:code]

      check_pin = Pin::Check.call(token, code)

      check_pin.to_json
    end
  end
end
