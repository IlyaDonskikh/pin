class Pin
  attr_accessor :code, :token, :expire

  def initialize(params = {})
    @token = params[:token]
    @code = params[:code]
    @expire = params[:expire]
  end

  def self.get_code_by(token)
    REDIS.get(token)
  end

  def self.create(params = {})
    new(params).save
  end

  def self.delete(token)
    REDIS.del(token)
  end

  def save
    REDIS.set(token, code)
    REDIS.expire(token, expire) if expire

    true
  end
end
