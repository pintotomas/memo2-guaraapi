require 'spec_helper'
require 'byebug'

REQUIRED_USER_NAME = 'DEBE TENER USER_NAME PARA CONSULTAR'.freeze
REQUIRED_FULL_NAME = 'DEBE TENER NOMBRE Y APELLIDO PARA CONSULTAR'.freeze

RSpec.describe '/students' do
  #  pending "add some examples to #{__FILE__}" do
  let!(:subject_algebra) do
    Subject.new(name: 'Algebra 2', requires_proyector: true, requires_lab: false,
                professor: 'F.I', id: 6201, quota: 9, type: 'coloquio')
  end

  let!(:subject_chemical) do
    Subject.new(name: 'Quimica', requires_proyector: true, requires_lab: false,
                professor: 'F.I', id: 6204, quota: 9, type: 'coloquio')
  end

  let!(:inscription_algebra) do
    SubjectRepository.new.save(subject_algebra)
    inscription = Inscription.new(id: 1, student_id: 'Rob123',
                                  subject_id: subject_algebra.id, status: Inscription::INSCRIBED)
    InscriptionsRepository.new.save(inscription)
    inscription
  end

  let!(:inscription_chemical) do
    inscription = Inscription.new(id: 2, student_id: 'Rob123',
                                  subject_id: subject_chemical.id, status: Inscription::INSCRIBED)
    inscription
  end

  before(:each) do
    ScoresRepository.new.delete_all
    InscriptionsRepository.new.delete_all
    SubjectRepository.new.delete_all
    header 'API_TOKEN', ENV['HTTP_API_TOKEN']
  end

  it 'consult academic offer' do
    SubjectRepository.new.save(subject_algebra)
    params = { "usernameAlumno": 'JuanPerez' }
    get '/materias', params
    response = JSON.parse(last_response.body)
    expect(response.first[1][0]['codigo']).to eq subject_algebra.id
  end

  it 'consult subjects in which I inscribed' do
    SubjectRepository.new.save(subject_chemical)
    InscriptionsRepository.new.save(inscription_chemical)
    params = { "usernameAlumno": inscription_chemical.student_id, "codigoMateria": subject_chemical.id }
    get '/inscripciones', params
    response = JSON.parse(last_response.body)
    expect(response.first[1][0]['codigo']).to eq subject_chemical.id
  end

  it 'consult my status in a subject' do
    SubjectRepository.new.save(subject_chemical)
    InscriptionsRepository.new.save(inscription_chemical)

    params = { "usernameAlumno":
    inscription_algebra.student_id, "codigoMateria": subject_chemical.id }
    get '/materias/estado', params
    expect(JSON.parse(last_response.body)['estado']).to eq Inscription::INSCRIBED
  end

  it 'consult my grades in a subject before it was qualified' do
    SubjectRepository.new.save(subject_chemical)
    InscriptionsRepository.new.save(inscription_chemical)
    params = { "usernameAlumno": inscription_algebra.student_id, "codigoMateria": subject_chemical.id }
    get '/materias/estado', params
    expect(JSON.parse(last_response.body)['nota_final']).to eq nil
  end

  it 'create valid inscription' do
    SubjectRepository.new.save(subject_algebra)
    post '/alumnos', '{"nombre_completo":"Juan Perez","codigo_materia":' + subject_algebra.id.to_s + ',"username_alumno":"juanperez"}'
    response = JSON.parse(last_response.body)
    expect(last_response.status).to eq 201
    expect(response['resultado']).to eq Inscription::SUCCESSFUL_INSCRIPTION
  end

  it 'create inscription and the student already was inscribed' do
    SubjectRepository.new.save(subject_algebra)
    post '/alumnos', '{"nombre_completo":"Juan Perez","codigo_materia":' + subject_algebra.id.to_s + ',"username_alumno":"juanperez"}'
    post '/alumnos', '{"nombre_completo":"Juan Perez","codigo_materia":' + subject_algebra.id.to_s + ',"username_alumno":"juanperez"}'
    expect(last_response.status).to eq 400
    response = JSON.parse(last_response.body)
    expect(response['error']).to eq Inscription::DUPLICATE_INSCRIPTION
  end

  it 'create inscription to a subject that does not exist' do
    post '/alumnos', '{"nombre_completo":"Juan Perez","codigo_materia":"1001","username_alumno":"juanperez"}'
    expect(last_response.status).to eq 500
  end

  describe 'call Students RESTs without userName' do
    it 'consult academic offer' do
      SubjectRepository.new.save(subject_algebra)
      params = { "nada": 'nada' }
      get '/materias', params
      response = JSON.parse(last_response.body)
      expect(response['error']).to eq REQUIRED_USER_NAME
    end

    it 'consult subjects in which I inscribed' do
      SubjectRepository.new.save(subject_chemical)
      InscriptionsRepository.new.save(inscription_chemical)
      params = { "codigoMateria": subject_chemical.id }
      get '/inscripciones', params
      response = JSON.parse(last_response.body)
      expect(response['error']).to eq REQUIRED_USER_NAME
    end

    it 'consult my status in a subject' do
      SubjectRepository.new.save(subject_chemical)
      InscriptionsRepository.new.save(inscription_chemical)
      params = { "codigoMateria": subject_chemical.id }
      get '/materias/estado', params
      expect(response['error']).to eq REQUIRED_USER_NAME
    end
  end
end
