describe SubjectRepository do
  let(:repository) { described_class.new }

  let(:subject_one) do
    subject_saved = Subject.new(name: 'Analisis 3', professor: 'Sirne', code: '6201')
    repository.save(subject_saved)
    subject_saved
  end

  describe 'find subject by name' do
    it 'should find the subject' do
      subject_found = repository.find_by_name(subject_one.name)
      expect(subject_found.name).to eq 'Analisis 3'
    end
  end
end
