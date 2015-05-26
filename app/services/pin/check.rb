class Pin::Check < Service::Base
  attr_accessor :token, :verification_code

  def initialize(token, verification_code)
    @token = token
    @verification_code = verification_code
    @max_attempts = 3
    @errors = []
  end

  def call
    verify!

    if @errors.empty?
      Pin.delete(token)

      { token: token }
    else
      { errors: @errors }
    end
  end

  private

    def verify!
      check_code_present
      check_token_present
      check_bruteforce
      check_code_valid
    end

    def check_code_present
      @errors << 'code not defined' unless verification_code
    end

    def check_token_present
      @errors << 'token not defined' unless token
    end

    def check_bruteforce
      key = token + ':counter'
      counter = REDIS.get key
      counter && count = REDIS.incr(key)

      return if counter && @max_attempts >= count

      REDIS.del key
      @errors << 'bruteforce protection'
    end

    def check_code_valid
      code = Pin.get_code_by(token)

      return if code && code == verification_code

      @errors << 'code not valid'
    end
end
