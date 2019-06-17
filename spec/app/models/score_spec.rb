describe Score do
  subject(:Score) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:inscription_id) }
    it { is_expected.to respond_to(:scores) }
    it { is_expected.to respond_to(:type_subject) }
  end

  describe 'valid' do
    it 'should be false when scores is nil' do
      score = described_class.new(id: 1, inscription_id: 2, scores: nil, type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false when there is no scores param' do
      score = described_class.new(id: 1, inscription_id: 2, type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false no scores is empty' do
      score = described_class.new(id: 1, inscription_id: 2, scores: [], type_subject: 'parciales')
      expect(score.valid?).to eq false
    end
  end
end
