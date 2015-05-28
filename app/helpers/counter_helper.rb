module CounterHelper
  def generate_counter_key_by(value)
    'counters:' + value.to_s
  end
end