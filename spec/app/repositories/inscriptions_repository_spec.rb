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

  let!(:subject_two) do
    subject = Subject.new(name: 'Biologia',
                          professor: 'Palermo', id: 321, quota: 9,
                          type: 'coloquio', requires_proyector: true,
                          requires_lab: false)
    subject
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

  describe 'find inscription by student and subject id' do
    it 'should raise foreign key constraint violation if subject doesnt exist in database' do
      expect { repository.save(inscription_without_saved_subejct) }.to raise_error Sequel::ForeignKeyConstraintViolation
    end
    it 'should save inscription correctly if the subject was saved before' do
      inscription = Inscription.new(subject_id: subject_one.id,
                                    student_id: 'Rob123', status: 'inscripto')
      repository.save(inscription)
    end
  end

  describe 'There are 2 subjects and I only inscribe in one' do
    it 'There are 2 subjects and I only inscribe in one' do
      subjects_repository.save(subject_two)
      inscription = Inscription.new(subject_id: subject_one.id,
                                    student_id: 'Rob123', status: 'inscripto')
      inscribed_subejcts = repository.my_inscribed_inscriptions(inscription.student_id)
      expect(inscribed_subejcts[0][:subject_id]).to eq inscription.subject_id
    end
  end
end
