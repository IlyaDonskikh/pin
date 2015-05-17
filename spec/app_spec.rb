describe 'Wheely Pin Application' do
  it 'create pin' do
    post 'create'

    expect(last_response.body).to eq('true')
  end

  it 'return token' do
    token = 'wheely_registration2'
    code = '1242'
    Pin.create(token: token, code: code, expire: 120)

    post 'check', token: token, code: code

    response = JSON.parse(last_response.body.to_s)
    result = { 'token' => token }
    expect(response).to eq(result)
  end

  it 'return error if code invalid' do
    post 'check', token: 123, code: 22

    response = JSON.parse(last_response.body)
    result = { 'errors' => ['code not valid'] }

    expect(response).to eq(result)
  end
end
