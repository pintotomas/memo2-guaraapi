describe ScoresRepository do
  after(:each) do
    repository.delete_all
    SubjectRepository.new.delete_all
  end

  let(:repository) { described_class.new }

  let(:subjects_repository) { SubjectRepository.new }
  let(:inscriptions_repository) { InscriptionsRepository.new }

  let!(:subject_one) do
    subject_saved = Subject.new(name: 'Analisis 3',
                                professor: 'Sirne', id: 123, quota: 9,
                                type: 'coloquio', requires_proyector: true,
                                requires_lab: false)
    subjects_repository.save(subject_saved)
    subject_saved
  end

  let!(:inscription_one) do
    inscription_saved = Inscription.new(id: 1,
                                        student_id: 'Rob123', subject_id: 123, status: 'inscripto')
    inscriptions_repository.save(inscription_saved)

    inscription_saved
  end

  describe 'find score  by inscription id' do
    it 'should raise foreign key constraint violation if subject doesnt exist in database' do
      score = Score.new(id: 1, inscription_id: 22, scores: [1], type_subject: 'coloquio')
      expect { repository.save(score) }.to raise_error Sequel::ForeignKeyConstraintViolation
    end

    it 'should save score correctly if the incription was saved before' do
      score = Score.new(id: 1,
                        inscription_id: inscription_one.id, scores: [1], type_subject: 'coloquio')
      repository.save(score)
    end
  end
end
