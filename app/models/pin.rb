class Pin
  attr_accessor :code, :token, :expire

  def initialize(params = {})
    @token = params[:token]
    @code = params[:code]
    @expire = params[:expire]
  end

  def self.find(token)
    code = REDIS.get(token)

    Pin.new(code: code, token: token)
  end

  def save
    REDIS.set(token, code)
    REDIS.expire(token, expire)

    true
  end

  private
    def generate_code
      (0...4).map { (1..9).to_a.sample }.join
    end
end