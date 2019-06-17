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

    it 'should be false when scores is empty' do
      score = described_class.new(id: 1, inscription_id: 2, scores: [], type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false when scores contains something that is not a number' do
      score = described_class.new(id: 1, inscription_id: 2, scores: %w[a b], type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false when one score contains something that is not a number' do
      score = described_class.new(id: 1, inscription_id: 2, scores: [1, 'a'], type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false one score contains something a score greater than 10' do
      score = described_class.new(id: 1, inscription_id: 2, scores: [1, 11], type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be true when all scores are positive numbers smaller than or equal to 10' do
      score = described_class.new(id: 1, inscription_id: 2, scores: [1, 10], type_subject: 'parciales')
      expect(score.valid?).to eq true
    end

    it 'should be false false when a score is negative' do
      score = described_class.new(id: 1, inscription_id: 2, scores: [1, -1], type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false false when a score is not an array' do
      score = described_class.new(id: 1, inscription_id: 2, scores: 1, type_subject: 'parciales')
      expect(score.valid?).to eq false
    end

    it 'should be false false when a score is a word' do
      score = described_class.new(id: 1, inscription_id: 2, scores: 'falafel', type_subject: 'parciales')
      expect(score.valid?).to eq false
    end
  end
end
