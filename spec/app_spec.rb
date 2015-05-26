describe 'pin application' do
  it 'create pin' do
    post 'pins/', token: generate_number

    response = format_response(last_response)
    result = { 'success' => true }

    expect(response).to eq(result)
  end

  it 'create counter' do
    token = generate_number

    post 'pins/', token: token

    key = token + ':counter'
    counter = REDIS.get key

    expect('0').to eq(counter)
  end

  it 'return token' do
    token = generate_number
    create_pin = Pin::Create.call(token, nil, 1000)
    code = create_pin.code

    post "pins/#{token}/check", code: code

    response = format_response(last_response)
    result = { 'token' => token }

    expect(response).to eq(result)
  end

  it 'return error if code invalid' do
    token = generate_number
    Pin::Create.call(token, nil, 1000)

    post "pins/#{token}/check", code: generate_number

    response = format_response(last_response)
    result = { 'errors' => ['code not valid'] }

    expect(response).to eq(result)
  end

  it 'delete pin if more than three attempts' do
    token = generate_number
    Pin::Create.call(token, nil, 1000)

    4.times do
      post "pins/#{token}/check", code: generate_number
    end

    response = format_response(last_response)
    result = { 'errors' => ['bruteforce protection', 'code not valid'] }

    expect(response).to eq(result)
  end

  private

    def generate_number
      (9999 * rand).to_i.to_s
    end

    def format_response(response)
      JSON.parse(response.body)
    end
end
