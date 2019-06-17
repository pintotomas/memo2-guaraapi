require 'spec_helper'

RSpec.describe '/professors' do
  let!(:subject_saved) do
    subject = Subject.new(name: 'Analisis 3',
                          professor: 'Sirne', id: 6201, quota: 9, type: 'coloquio',
                          requires_proyector: true, requires_lab: false)
    SubjectRepository.new.save(subject)
    subject
  end

  let!(:inscription_to_save) do
    inscription = Inscription.new(id: 1, student_id: 'Rob123',
                                  subject_id: subject_saved.id, status: Inscription::INSCRIBED)
    inscription
  end

  let!(:request_to_asign_score) do
    InscriptionsRepository.new.save(inscription_to_save)
    params = { codigo_materia: subject_saved.id, notas: '[1]',
               username_alumno: inscription_to_save.student_id }
    params
  end

  let!(:request_to_asign_invalid_score) do
    InscriptionsRepository.new.save(inscription_to_save)
    params = { codigo_materia: subject_saved.id, notas: 'aprobado',
               username_alumno: inscription_to_save.student_id }
    params
  end

  before(:each) do
    header 'API_TOKEN', ENV['HTTP_API_TOKEN']
  end

  after(:each) do
    ScoresRepository.new.delete_all
    SubjectRepository.new.delete_all
  end

  describe 'create a subject' do
    it 'create a subject with invalid type' do
      post '/materias', '{"codigo":1000,"docente":"Roberto","nombreMateria":"Algo I","modalidad":"invalida","cupo":25,"laboratorio":true,"proyector":false }'
      message = JSON.parse(last_response.body)['error']
      expect(last_response.status).to eq 400
      expect(message).to eq 'MODALIDAD_INVALIDA'
    end

    it 'create two subjects with same code' do
      post '/materias', '{"codigo":1000,"docente":"Roberto","nombreMateria":"Algo I","modalidad":"parciales","cupo":25,"laboratorio":true,"proyector":false }'
      post '/materias', '{"codigo":1000,"docente":"Gaston","nombreMateria":"Algo II","modalidad":"parciales","cupo":26,"laboratorio":false,"proyector":false }'
      message = JSON.parse(last_response.body)['error']
      expect(last_response.status).to eq 400
      expect(message).to eq 'MATERIA_DUPLICADA'
    end

    it 'create a subject without name' do
      post '/materias', '{"codigo":1000,"docente":"Roberto","modalidad":"parciales","cupo":25,"laboratorio":true,"proyector":false }'
      message = JSON.parse(last_response.body)['error']
      expect(last_response.status).to eq 400
      expect(message).to eq Subject::MANDATORY_NAME
    end
  end

  describe 'assign score to test' do
    it 'assign score to test correctly' do
      post '/calificar', request_to_asign_score.to_json
      expect(last_response.status).to eq 200
    end

    it 'Assign a student s test score without registration' do
      params = { codigo_materia: subject_saved.id, notas: '[1]',
                 username_alumno: 'JuanPerez' }
      post '/calificar', params.to_json
      expect(last_response.status).to eq 400
      expect(last_response.body).to include('ALUMNO_INCORRECTO')
    end

    it 'unsubscribe after a asign score to test' do
      post '/calificar', request_to_asign_score.to_json
      post '/calificar', request_to_asign_score.to_json
      expect(last_response.status).to eq 400
      expect(last_response.body).to include('ALUMNO_INCORRECTO')
    end

    it 'assign invalid score to test' do
      post '/calificar', request_to_asign_invalid_score.to_json
      expect(last_response.status).to eq 400
      expect(last_response.body).to include('NOTA_INVALIDA')
    end
  end
end
