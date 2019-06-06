require 'spec_helper'
require 'byebug'

RSpec.describe '/students' do
  #  pending "add some examples to #{__FILE__}" do
  let(:subject_saved) do
    Subject.new(name: 'Algebra 2', requires_proyector: true, requires_lab: false,
                professor: 'F.I', code: '6201', quota: 9, type: 'coloquio')
  end

  before(:each) do
    SubjectRepository.new.delete_all
  end

  it 'consult academic offer' do
    SubjectRepository.new.save(subject_saved)
    get '/materias'
    response = JSON.parse(last_response.body)
    expect(response.first[1][0]['codigo'].to_s).to eq subject_saved.code
  end
end
