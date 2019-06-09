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

  let!(:inscription_one) do
    inscription = Inscription.new(id: 1,
                                  student_id: 'Rob123', subject_id: 245, status: 'inscripto')
    inscription
  end

  describe 'find inscription by student and subject id' do
    # rubocop:disable LineLength
    it 'should raise foreign key constraint violation if subject doesnt exist in database' do
      expect { repository.save(inscription_one) }.to raise_error Sequel::ForeignKeyConstraintViolation
    end
    # rubocop:enable LineLength
    it 'should save inscription correctly if the subject was saved before' do
      inscription = Inscription.new(subject_id: 123,
                                    student_id: 'Rob123', status: 'inscripto')
      repository.save(inscription)
    end
  end
end
