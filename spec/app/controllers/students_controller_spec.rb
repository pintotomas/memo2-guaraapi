require 'spec_helper'
require 'byebug'

RSpec.describe '/students' do
  #  pending "add some examples to #{__FILE__}" do
  let(:subject_saved) do
    Subject.new(name: 'Algebra 2', requires_proyector: true, requires_lab: false,
                professor: 'F.I', id: 6201, quota: 9, type: 'coloquio')
  end

  before(:each) do
    SubjectRepository.new.delete_all
    header 'API_TOKEN', ENV['HTTP_API_TOKEN']
  end

  it 'consult academic offer' do
    SubjectRepository.new.save(subject_saved)
    get '/materias'
    response = JSON.parse(last_response.body)
    expect(response.first[1][0]['codigo']).to eq subject_saved.id
  end

  it 'create valid inscription' do
    SubjectRepository.new.save(subject_saved)
    post '/alumnos', '{"nombre_completo":"Juan Perez","codigo_materia":' + subject_saved.id.to_s + ',"username_alumno":"juanperez"}'
    expect(last_response.status).to eq 201
  end

  it 'create inscription to a subject that does not exist' do
    post '/alumnos', '{"nombre_completo":"Juan Perez","codigo_materia":"1001","username_alumno":"juanperez"}'
    expect(last_response.status).to eq 500
  end
end
