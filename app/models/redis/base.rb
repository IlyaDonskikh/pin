class Redis::Base
  attr_accessor :value, :key, :expire

  class << self
    def key_with_prefix(key)
      "#{name.downcase}s:#{key}"
    end

    def get_value_by(key)
      REDIS.get key_with_prefix(key)
    end

    def create(params = {})
      new(params).save
    end

    def delete(key)
      REDIS.del key_with_prefix(key)
    end

    def incr(key)
      REDIS.incr key_with_prefix(key)
    end
  end

  def initialize(attrs = {})
    attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  def key
    self.class.key_with_prefix(@key)
  end

  def save
    REDIS.set(key, value, ex: expire)

    true
  end
end
