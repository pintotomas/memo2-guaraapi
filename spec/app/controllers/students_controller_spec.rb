require 'spec_helper'

RSpec.describe '/students' do
  #  pending "add some examples to #{__FILE__}" do
  #    before(:each) do
  #      get '/students'
  #    end

  it 'returns hello world' do
    get '/students/academic_offer'
    expect(last_response.body).to eq 'Materia: Memo2, Código: 95.21, Docente: Nico Paez. Cupos: 25'
  end
end
