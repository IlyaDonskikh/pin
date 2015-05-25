describe 'pin application' do
  it 'create pin' do
    post 'create', token: generate_number

    response = format_response(last_response)
    result = { 'success' => true }

    expect(response).to eq(result)
  end

  it 'return token' do
    token = generate_number
    create_pin = Pin::Create.call(token, nil, 1000)
    code = create_pin.code

    post 'check', token: token, code: code

    response = format_response(last_response)
    result = { 'token' => token }

    expect(response).to eq(result)
  end

  it 'return error if code invalid' do
    post 'check', token: generate_number, code: generate_number

    response = format_response(last_response)
    result = { 'errors' => ['code not valid'] }

    expect(response).to eq(result)
  end

  private

    def generate_number
      (9999*rand).to_i.to_s
    end

    def format_response(response)
      JSON.parse(response.body)
    end
end
