class Counter
  def self.generate_key_by(value)
    value.to_s + ':counter'
  end
end
