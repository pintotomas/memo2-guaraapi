require 'spec_helper'

RSpec.describe 'health' do
  it '/reset should be forbidden during production' do
    header 'RACK_ENV', 'production'
    post '/reset'
    expect(last_response.status).to eq 403 # forbidden
  end
  it '/reset should not be forbidden if not in production' do
    header 'RACK_ENV', 'desarrollo'
    post '/reset'
    expect(last_response.status).to eq 200 # forbidden
  end
end
