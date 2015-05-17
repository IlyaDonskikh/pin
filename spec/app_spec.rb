describe 'pin application' do
  it 'create pin' do
    post 'create'

    expect(last_response.body).to eq('true')
  end

  it 'return token' do
    token = generate_number
    code = generate_number
    Pin.create(token: token, code: code, expire: 120)

    post 'check', token: token, code: code

    response = JSON.parse(last_response.body.to_s)
    result = { 'token' => token }
    expect(response).to eq(result)
  end

  it 'return error if code invalid' do
    post 'check', token: generate_number, code: generate_number

    response = JSON.parse(last_response.body)
    result = { 'errors' => ['code not valid'] }

    expect(response).to eq(result)
  end

  private

    def generate_number
      (0...4).map { (1..9).to_a.sample }.join
    end
end
