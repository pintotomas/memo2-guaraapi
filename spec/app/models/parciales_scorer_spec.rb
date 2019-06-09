describe ParcialesScorer do
  subject(:scorer) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:calculate_final_score) }
  end

  describe 'calculate_final_score' do
    it 'returns default values when score type is different than parciales' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [5], type_subject: 'tareas')
      )
      expect(final_score.passed_course).to eq false
      expect(final_score.score).to eq 0
    end

    it 'returns average of scores' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [5, 3], type_subject: 'parciales')
      )
      expect(final_score.score).to eq 4
    end

    it 'returns passed_course true when score is greater than 6' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [7, 7], type_subject: 'parciales')
      )
      expect(final_score.passed_course).to eq true
    end

    it 'returns passed_course true when score is equal to 6' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [6, 6], type_subject: 'parciales')
      )
      expect(final_score.passed_course).to eq true
    end

    it 'returns passed_course false when score is less than 6' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [6, 5], type_subject: 'parciales')
      )
      expect(final_score.passed_course).to eq false
    end

    it 'raises ParcialesMustHaveAtLeastOneScore when score has 0 values' do
      score = Score.new(id: 1, inscription_id: 2, scores: [], type_subject: 'parciales')
      expect { scorer.calculate_final_score(score) }
        .to raise_error(ParcialesMustHaveAtLeastOneScore)
    end
  end
end
