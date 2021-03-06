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
    subject_saved = Subject.new(name: 'Biologia',
                                professor: 'Palermo', id: 321, quota: 9,
                                type: 'coloquio', requires_proyector: true,
                                requires_lab: false)
    subjects_repository.save(subject_saved)
    subject_saved
  end

  let!(:inscription_without_saved_subejct) do
    inscription = Inscription.new(student_id: 'Rob123', subject_id: 245, status: Inscription::INSCRIBED)
    inscription
  end

  let!(:inscription_to_save_one) do
    inscription = Inscription.new(student_id: 'Rob123', in_progress: true,
                                  subject_id: subject_one.id, status: Inscription::INSCRIBED)
    repository.save(inscription)
    inscription
  end

  let!(:inscription_to_save_approved) do
    inscription = Inscription.new(student_id: 'Rob123', in_progress: true,
                                  subject_id: subject_two.id, status: Inscription::APPROVED_CONST)
    repository.save(inscription)
    inscription
  end

  let(:inscription_to_save_one_not_progress) do
    inscription = Inscription.new(student_id: 'Rob123', in_progress: false,
                                  subject_id: subject_one.id, status: 'fruta')
    repository.save(inscription)
    inscription
  end

  after(:each) do
    repository.delete_all
    SubjectRepository.new.delete_all
  end

  describe 'find inscription by student and subject id' do
    it 'should raise foreign key constraint violation if subject doesnt exist in database' do
      expect { repository.save(inscription_without_saved_subejct) }.to raise_error Sequel::ForeignKeyConstraintViolation
    end
    it 'should save inscription correctly if the subject was saved before' do
      inscription = Inscription.new(subject_id: subject_one.id,
                                    student_id: 'Rob123', status: Inscription::INSCRIBED)
      repository.save(inscription)
    end
  end

  describe 'Filter my subjects' do
    it 'There are 2 subjects and I only inscribe in one' do
      subject_two
      inscribed_subejcts = repository.my_inscribed_inscriptions(inscription_to_save_one.student_id)
      expect(inscribed_subejcts[0][:subject_id]).to eq inscription_to_save_one.subject_id
    end

    it 'my subjects that I did not approve' do
      inscription_to_save_one
      inscription_to_save_approved
      subejcts = repository.inscribed_subjects_not_approbed(inscription_to_save_one.student_id)
      expect(subejcts.size).to eq 1
    end

    it 'there are two subjects but I am not subcrit to any' do
      subject_one
      subject_two
      subejcts = repository.inscribed_subjects_not_approbed('Marcos')
      expect(subejcts.size).to eq 2
    end

    it 'there are two subjects, I only inscribe in one but it is approved ' do
      subject_one
      inscription_to_save_approved
      subejcts = repository.inscribed_subjects_not_approbed(
        inscription_to_save_approved.student_id
      )
      expect(subejcts.size).to eq 1
    end

    it 'There are 2 inscriptions, but one in progress' do
      inscription_to_save_one_not_progress
      inscription_to_save_one
      inscription_in_progress = repository.find_by_student_and_subject_id_and_in_progress(inscription_to_save_one.student_id,
                                                                                          inscription_to_save_one.subject_id)
      expect(inscription_in_progress.subject_id).to eq inscription_to_save_one.subject_id
    end
  end

  describe 'inscriptions_in_course' do
    it 'There are 2 inscriptions, but one in progress, returns 1' do
      inscription_to_save_one_not_progress
      inscription_to_save_one
      expect(repository.inscriptions_in_course(inscription_to_save_one.subject_id)).to eq 1
    end

    it 'Returns 0 when no inscriptions are foundfor the subject id' do
      expect(repository.inscriptions_in_course(999)).to eq 0
    end
  end
end
