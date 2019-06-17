describe Subject do
  subject(:user) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:professor) }
    it { is_expected.to respond_to(:quota) }
    it { is_expected.to respond_to(:type) }
    it { is_expected.to respond_to(:requires_lab) }
    it { is_expected.to respond_to(:requires_proyector) }
  end

  describe 'valid?' do
    it 'should be true when name, professor, id, type and quota are not blank' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: '6201', quota: '3',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq true
    end

    it 'should be false when type is wrong' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: '6201', quota: '3',
                                    requires_proyector: true, type: 'test')
      expect(subject.valid?).to eq false
      expect(subject.errors.messages.values[0][0]).to eq 'MODALIDAD_INVALIDA'
    end

    it 'should be false when professor is blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: '', id: '6201')
      expect(subject.valid?).to eq false
    end

    it 'should be false when name is blank' do
      subject = described_class.new(name: '',
                                    professor: 'Sirne', id: '6201')
      expect(subject.valid?).to eq false
    end

    it 'should be false when id is blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', id: '')
      expect(subject.valid?).to eq false
    end

    it 'should be false when type is blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', id: '1234', type: '')
      expect(subject.valid?).to eq false
    end

    it 'should be false when requires_proyector is not provided' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', id: '1234', type: 'coloquio')
      expect(subject.valid?).to eq false
    end

    it 'should be false when requires_lab is not provided' do
      subject = described_class.new(name: 'Analisis 2', requires_proyector: true,
                                    professor: 'Sirne', id: '1234', type: 'coloquio')
      expect(subject.valid?).to eq false
    end

    it 'should be false when subject id is greather than 9999' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: '10000', quota: '3',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq false
      expect(subject.errors.messages[:id][0]).to eq Subject::INVALID_SUBJECT_ID
    end

    it 'should be false when quota is over 300' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: '6201', quota: '301',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq false
    end

    it 'should be true when quota is 300' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: '6201', quota: '300',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq true
    end

    it 'should be true when quota is less than 300' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: '6201', quota: '299',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq true
    end

    it 'should be false when id is nil' do
      subject = described_class.new(name: 'Analisis 2', requires_lab: false,
                                    professor: 'Sirne', id: nil, quota: '3',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq false
    end
  end
end
