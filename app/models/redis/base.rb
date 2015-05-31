class Redis::Base
  attr_accessor :value, :key, :expire

  def initialize(attrs = {})
    attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  def self.prefix
    "#{name.downcase}s:"
  end

  def self.combine_prefix(key)
    prefix + key.to_s
  end

  def self.get_value_by(key)
    key = combine_prefix(key)

    REDIS.get(key)
  end

  def self.create(params = {})
    new(params).save
  end

  def self.delete(key)
    key = combine_prefix(key)

    REDIS.del(key)
  end

  def self.incr(key)
    key = combine_prefix(key)

    REDIS.incr(key)
  end

  def save
    key = self.class.combine_prefix(self.key)

    REDIS.set(key, value, ex: expire)

    true
  end
end
