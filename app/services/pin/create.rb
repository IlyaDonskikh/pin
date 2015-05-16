class Pin::Create < Service::Base
  attr_accessor :token

  def initialize(token)
    @token = token
    @code = generate_code
    @expire = 10
  end

  def call
    @pin = Pin.new(token: @token, code: @code, expire: @expire)
    @pin.save

    true
  end

  private
    def generate_code
      (0...4).map { (1..9).to_a.sample }.join
    end
end