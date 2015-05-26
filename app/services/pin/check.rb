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
      return if verification_code

      @errors << I18n.t('code_not_defined', scope: [:pin, :errors])
    end

    def check_token_present
      return if token

      @errors << I18n.t('token_not_defined', scope: [:pin, :errors])
    end

    def check_bruteforce
      key = Counter.generate_key_by(token)
      counter = REDIS.get key
      counter && count = REDIS.incr(key)

      return if counter && @max_attempts >= count

      REDIS.del key
      Pin.delete token
      @errors << I18n.t('bruteforce_protection', scope: [:pin, :errors])
    end

    def check_code_valid
      code = Pin.get_code_by(token)

      return if code && code == verification_code

      @errors << I18n.t('code_not_valid', scope: [:pin, :errors])
    end
end
