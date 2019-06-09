describe ColoquioScorer do
  subject(:scorer) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:calculate_final_score) }
  end

  describe 'calculate_final_score' do
    it 'returns default values when score type is different than coloquio' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [5], type_subject: 'tareas')
      )
      expect(final_score.passed_course).to eq false
      expect(final_score.score).to eq 0
    end
  end
end
