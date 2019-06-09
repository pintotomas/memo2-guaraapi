describe Scorer do
  subject(:scorer) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:calculate_final_score) }
  end

  describe 'calculate_final_score' do
    it 'returns default values when no score is provided' do
      scorer = described_class.new
      final_score = scorer.calculate_final_score
      expect(final_score.passed_course).to eq false
      expect(final_score.score).to eq 0
    end
  end
end
