module WheelyPin
  class Application < Sinatra::Base
    before do
      content_type :json
    end

    post '/create' do
      create_pin = Pin::Create.call(params[:token], nil)

      create_pin.to_json
    end

    post '/check' do
      token = params[:token]
      code = params[:code]

      check_pin = Pin::Check.call(token, code)

      check_pin.to_json
    end
  end
end
