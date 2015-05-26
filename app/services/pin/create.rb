class Pin::Create < Service::Base
  attr_accessor :token, :code

  def initialize(token, phone, expire = 120)
    @token = token
    @phone = phone
    @code = generate_code
    @expire = expire # seconds
  end

  def call
    Pin.create(token: token, code: code, expire: @expire)
    send_code

    self
  end

  private

    def generate_code
      (9999 * rand).to_i
    end

    def send_code
      # Send sms to phone number
    end
end
