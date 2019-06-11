describe InscriptionsRepository do
  let(:repository) { described_class.new }

  let(:subjects_repository) { SubjectRepository.new }

  let!(:subject_one) do
    subject_saved = Subject.new(name: 'Analisis 3',
                                professor: 'Sirne', id: 123, quota: 9,
                                type: 'coloquio', requires_proyector: true,
                                requires_lab: false)
    subjects_repository.save(subject_saved)
    subject_saved
  end

  let!(:inscription_without_saved_subejct) do
    inscription = Inscription.new(student_id: 'Rob123', subject_id: 245, status: 'inscripto')
    inscription
  end

  let!(:inscription_to_save) do
    inscription = Inscription.new(student_id: 'Rob123',
                                  subject_id: subject_one.id, status: 'inscripto')
    inscription
  end

  it 'find my inscriptions' do
    repository.save(inscription_to_save)
    inscriptions = repository.find_by_student_and_in_progress(inscription_to_save.student_id)
    expect(inscriptions.first.student_id).to eq inscription_to_save.student_id
    expect(inscriptions.first.subject_id).to eq inscription_to_save.subject_id
  end

  describe 'find inscription by student and subject id' do
    # rubocop:disable LineLength
    it 'should raise foreign key constraint violation if subject doesnt exist in database' do
      expect { repository.save(inscription_without_saved_subejct) }.to raise_error Sequel::ForeignKeyConstraintViolation
    end
    # rubocop:enable LineLength
    it 'should save inscription correctly if the subject was saved before' do
      inscription = Inscription.new(subject_id: 123,
                                    student_id: 'Rob123', status: 'inscripto')
      repository.save(inscription)
    end
  end
end
