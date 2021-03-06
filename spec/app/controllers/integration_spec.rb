RSpec.describe 'integration tests' do
  let!(:subject_algebra) do
    s = Subject.new(name: 'Algebra 2', requires_proyector: true, requires_lab: false,
                    professor: 'F.I', id: 6201, quota: 9, type: 'coloquio')
    SubjectRepository.new.save(s)
  end

  let!(:subject_chemical) do
    s = Subject.new(name: 'Quimica', requires_proyector: true, requires_lab: false,
                    professor: 'F.I', id: 6204, quota: 9, type: 'coloquio')
    SubjectRepository.new.save(s)
  end

  let!(:inscription_to_save) do
    inscription = Inscription.new(id: 1, student_id: 'tomas123', subject_id: 6204, status: Inscription::INSCRIBED)
    InscriptionsRepository.new.save(inscription)
    inscription
  end

  let!(:second_inscription_to_save) do
    inscription = Inscription.new(id: 1, student_id: 'tomas123',
                                  subject_id: 6201, status: Inscription::INSCRIBED)
    InscriptionsRepository.new.save(inscription)
    inscription
  end

  before(:each) do
    header 'API_TOKEN', ENV['HTTP_API_TOKEN']
  end

  after(:each) do
    ScoresRepository.new.delete_all
    SubjectRepository.new.delete_all
  end

  it 'qualify a student on two approved subjects and ask for average grade and quantity of approved subjects' do
    params_algebra = { codigo_materia: 6201, notas: '[10]', username_alumno: 'tomas123' }
    params_chemical = { codigo_materia: 6204, notas: '[6]', username_alumno: 'tomas123' }
    post '/calificar', params_algebra.to_json
    post '/calificar', params_chemical.to_json
    promedio_params = { usernameAlumno: 'tomas123' }
    get '/alumnos/promedio', promedio_params
    expect(last_response.status).to eq 200
    # expect(JSON.parse(last_response.body)['materias_aprobadas']).to eq 2
    # expect(JSON.parse(last_response.body)['nota_promedio']).to eq 8
  end

  it 'qualify a student on two subjects (only one approved) and ask for average grade and quantity of approved subjects' do
    params_algebra = { codigo_materia: 6201, notas: '[10]', username_alumno: 'tomas123' }
    params_chemical = { codigo_materia: 6204, notas: '[2]', username_alumno: 'tomas123' }
    post '/calificar', params_algebra.to_json
    post '/calificar', params_chemical.to_json
    promedio_params = { usernameAlumno: 'tomas123' }
    get '/alumnos/promedio', promedio_params
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)['materias_aprobadas']).to eq 1
    expect(JSON.parse(last_response.body)['nota_promedio']).to eq 6.0
  end

  it '/promedio without any previous inscription' do
    promedio_params = { usernameAlumno: 'tomdsfgahsdfsfdsgsdf123' }
    get '/alumnos/promedio', promedio_params
    expect(JSON.parse(last_response.body)['materias_aprobadas']).to eq 0
    expect(JSON.parse(last_response.body)['nota_promedio']).to eq nil
  end

  it 'invalid API TOKEN' do
    header 'API_TOKEN', 'zaraza'
    get '/materias'
    expect(last_response.status).to eq 401
  end
end
