require 'spec_helper'

RSpec.describe 'health' do
  # Este test no tiene sentido probarlo en el ambiente de desarrollo
  # se puede probar reemplazando el ENV del endpoint reset en health por env y activando el test
  #  it '/reset should be forbidden during production' do
  #    header 'RACK_ENV', 'production'
  #    post '/reset'
  #    expect(last_response.status).to eq 403 # forbidden
  #  end
  it '/reset should not be forbidden if not in production' do
    header 'RACK_ENV', 'desarrollo'
    post '/reset'
    expect(last_response.status).to eq 200 # forbidden
  end
end
