require 'byebug'

describe SubjectRepository do
  let(:repository) { described_class.new }

  let!(:subject_one) do
    subject_saved = Subject.new(name: 'Analisis 3',
                                professor: 'Sirne', id: 6201, quota: 9,
                                type: 'coloquio', requires_proyector: true,
                                requires_lab: false)
    repository.save(subject_saved)
    subject_saved
  end

  describe 'find subject by name' do
    it 'should find the subject' do
      subject_found = repository.find_by_name(subject_one.name)
      expect(subject_found.name).to eq 'Analisis 3'
    end
  end

  describe 'subject code duplicated' do
    it 'save a subject with same code than before should raise error' do
      dupe_subject = Subject.new(name: 'Analisis 4', professor: 'Acero', id: 6201, quota: 25,
                                 type: 'parciales', requires_proyector: true,
                                 requires_lab: false)
      expect { repository.insert_subject(dupe_subject) }.to raise_error(Sequel::UniqueConstraintViolation)
    end
    it 'subject exists? when subject does not exist ' do
      expect(repository.subject_exists?(850_981_237_120)).to eq false
    end
  end
end
