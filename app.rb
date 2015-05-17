module WheelyPin
  class Application < Sinatra::Base
    before do
      content_type :json
    end

    post '/create' do
      token = params[:token]
      phone = params[:phone]
      expire = params[:expire]

      Pin::Create.call(token, phone, expire)
      result = { success: true }

      result.to_json
    end

    post '/check' do
      token = params[:token]
      code = params[:code]

      check_pin = Pin::Check.call(token, code)

      check_pin.to_json
    end
  end
end
