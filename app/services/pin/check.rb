class Pin::Check < Service::Base
  attr_accessor :token, :verification_code

  def initialize(token, verification_code)
    @token = token
    @verification_code = verification_code
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
      check_code_valid
    end

    def check_code_present
      @errors << 'code not defined' unless verification_code
    end

    def check_token_present
      @errors << 'token not defined' unless token
    end

    def check_code_valid
      code = Pin.get_code_by(token)

      @errors << 'code not valid' if !code || code != verification_code
    end
end
