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
    params = { codigo_materia: subject_saved.id, notas: '1',
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

  describe 'assign score to test' do
    it 'assign score to test correctly' do
      post '/calificar', request_to_asign_score.to_json
      expect(last_response.status).to eq 201
    end

    it 'Assign a student s test score without registration' do
      params = { codigo_materia: subject_saved.id, notas: '1',
                 username_alumno: 'JuanPerez' }
      post '/calificar', params.to_json
      expect(last_response.status).to eq 400
      expect(last_response.body).to eq 'El alumno no esta inscripto'
    end

    it 'unsubscribe after a asign score to test' do
      post '/calificar', request_to_asign_score.to_json
      post '/calificar', request_to_asign_score.to_json
      expect(last_response.status).to eq 400
      expect(last_response.body).to eq 'El alumno no esta inscripto'
    end
  end
end
