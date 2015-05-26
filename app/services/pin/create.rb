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
    create_bruteforce_protection
    send_code

    self
  end

  private

    def generate_code
      (9999 * rand).to_i
    end

    def create_bruteforce_protection
      key = Counter.generate_key_by(token)

      REDIS.set(key, 0, ex: @expire)
    end

    def send_code
      # Send sms to phone number
    end
end
