describe FinalScore do
  subject(:finalScore) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:score) }
    it { is_expected.to respond_to(:passed_course) }
  end

  describe 'initialization' do
    it 'initialize with passed_course false and score 0 when no parameters are provided' do
      final_score = described_class.new({})
      expect(final_score.passed_course).to eq false
      expect(final_score.score).to eq 0
    end

    it 'initializes with parameters' do
      final_score = described_class.new(passed_course: true, score: 7)
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 7
    end
  end
end
