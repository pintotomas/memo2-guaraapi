describe Subject do
  subject(:user) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:professor) }
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:quota) }
  end

  describe 'valid?' do
    it 'should be true when name, professor, code, type and quota are not blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', code: '6201', quota: '3',
                                    requires_proyector: true, type: 'coloquio')
      expect(subject.valid?).to eq true
    end

    it 'should be false when professor is blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: '', code: '6201')
      expect(subject.valid?).to eq false
    end

    it 'should be false when name is blank' do
      subject = described_class.new(name: '',
                                    professor: 'Sirne', code: '6201')
      expect(subject.valid?).to eq false
    end

    it 'should be false when code is blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', code: '')
      expect(subject.valid?).to eq false
    end

    it 'should be false when type is blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', code: '1234', type: '')
      expect(subject.valid?).to eq false
    end

    it 'should be false when requires_proyector is not provided' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', code: '1234', type: 'coloquio')
      expect(subject.valid?).to eq false
    end
  end
end
