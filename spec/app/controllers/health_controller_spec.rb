require 'spec_helper'

RSpec.describe 'health' do
  it '/reset should be forbidden during production' do
    header 'RACK_ENV', 'production'
    post '/reset'
    expect(last_response.status).to eq 403 # forbidden
  end
end
