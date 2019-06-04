require 'spec_helper'
require 'byebug'

RSpec.describe '/students' do
  #  pending "add some examples to #{__FILE__}" do

  before(:each) do
    SubjectRepository.new.delete_all
  end

  it 'consult academic offer' do
    subject_saved = Subject.new(name: 'Algebra 2', professor: 'F.I', code: '6201', quota: 9)
    SubjectRepository.new.save(subject_saved)
    get '/students/academic_offer'
    response = JSON.parse(last_response.body)
    expect(response.first['codigo'].to_s).to eq subject_saved.code
  end
end
