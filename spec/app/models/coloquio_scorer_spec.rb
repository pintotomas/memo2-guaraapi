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

    it 'returns final score with passed_course false when score is less than 4' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [3], type_subject: 'coloquio')
      )
      expect(final_score.passed_course).to eq false
      expect(final_score.score).to eq 3
    end

    it 'returns final score with passed_course true when score is equal to 4' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [4], type_subject: 'coloquio')
      )
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 4
    end

    it 'returns final score with passed_course true when score is over 4' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [5], type_subject: 'coloquio')
      )
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 5
    end

    it 'raises ColoquioScoreHasToBePresentAndUniqueError when score has 2 values' do
      score = Score.new(id: 1, inscription_id: 2, scores: [5, 2], type_subject: 'coloquio')
      expect { scorer.calculate_final_score(score) }
        .to raise_error(ColoquioScoreHasToBePresentAndUniqueError)
    end

    it 'raises ColoquioScoreHasToBePresentAndUniqueError when score has 0 values' do
      score = Score.new(id: 1, inscription_id: 2, scores: [], type_subject: 'coloquio')
      expect { scorer.calculate_final_score(score) }
        .to raise_error(ColoquioScoreHasToBePresentAndUniqueError)
    end
  end
end
