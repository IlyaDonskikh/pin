class Pin
  attr_accessor :code, :token

  def initialize(params = {})
    @code = params[:code] || 'lol'
    @token = params[:token] || '22'
  end

  def self.find(code)
    token = REDIS.get(code)
    
    Pin.new(code: code, token: token)
  end

  def save
    REDIS.set(code: code, token: token)
  end
end