module WheelyPin
  class Application < Sinatra::Base
    before do
      content_type :json
    end

    before '/:locale/*' do
      I18n.locale       =       params[:locale] || :en
      request.path_info = '/' + params[:splat][0]
    end

    post '/pins/?' do
      token = params[:token]
      phone = params[:phone]
      expire = params[:expire]

      Pin::Create.call(token, phone, expire)
      result = { success: true }

      result.to_json
    end

    post '/pins/:token/check' do
      token = params[:token]
      code = params[:code]

      check_pin = Pin::Check.call(token, code)

      check_pin.to_json
    end
  end
end
