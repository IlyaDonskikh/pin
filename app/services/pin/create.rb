class Pin::Create < Service::Base
  attr_accessor :token

  def initialize(token)
    @token = token
    @code = generate_code
    @expire = 120 # seconds
  end

  def call
    @pin = Pin.new(token: @token, code: @code, expire: @expire)
    @pin.save

    send_code

    true
  end

  private

    def generate_code
      (0...4).map { (1..9).to_a.sample }.join
    end

    def send_code
      p @code # Sms sender
    end
end
