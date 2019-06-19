require 'spec_helper'

RSpec.describe 'GuaraApi::App::StudentsHelper' do
  subject(:student_helper) { helpers }

  let(:helpers) { Class.new }

  let!(:subjects_from_inscribed_subjects_not_approbed) do
    subjects_sequel = [{ id: 6204, name: 'Quimica', professor: 'F.I' }]
    subjects_sequel
  end

  before(:each) { helpers.extend GuaraApi::App::StudentsHelper }

  it 'quantity of approved subjects should be 0' do
    inscription1 = Inscription.new(id: 1, student_id: 2, subject_id: 3, status: 'DESAPROBADO', final_grade: 1)
    expect(student_helper.quantity_approved_subjects([inscription1])).to eq 0
  end
  it 'quantity of approved subjects should be 1' do
    inscription1 = Inscription.new(id: 1, student_id: 2, subject_id: 3, status: 'DESAPROBADO', final_grade: 1)
    inscription2 = Inscription.new(id: 1, student_id: 2, subject_id: 3, status: 'APROBADO', final_grade: 10)
    expect(student_helper.quantity_approved_subjects([inscription1, inscription2])).to eq 1
  end

  it 'build response from ' do
    response = student_helper.build_subjects_response_from_sequel(subjects_from_inscribed_subjects_not_approbed)
    expect(response[0][:codigo]).to eq subjects_from_inscribed_subjects_not_approbed[0][:id]
    expect(response[0][:materia]).to eq subjects_from_inscribed_subjects_not_approbed[0][:name]
    expect(response[0][:docente]).to eq subjects_from_inscribed_subjects_not_approbed[0][:professor]
  end
end
