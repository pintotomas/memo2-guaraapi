describe Subject do
  subject(:user) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:professor) }
    it { is_expected.to respond_to(:code) }
  end

  describe 'valid?' do
    it 'should be true when name, professor, code are not blank' do
      subject = described_class.new(name: 'Analisis 2',
                                    professor: 'Sirne', code: '6201')
      expect(subject.valid?).to eq true
    end
  end
end
