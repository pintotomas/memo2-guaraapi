describe TareasScorer do
  subject(:scorer) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:calculate_final_score) }
  end

  describe 'calculate_final_score' do
    it 'returns default values when score type is different than tareas' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [5], type_subject: 'coloquio')
      )
      expect(final_score.passed_course).to eq false
      expect(final_score.score).to eq 0
    end

    it 'raises ParcialesMustHaveAtLeastOneScore when score has 0 values' do
      score = Score.new(id: 1, inscription_id: 2, scores: [], type_subject: 'tareas')
      expect { scorer.calculate_final_score(score) }
        .to raise_error(TareasMustHaveAtLeastOneScoreError)
    end

    it 'returns passed_course true when average is greater than 6' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [7, 7], type_subject: 'tareas')
      )
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 7
    end

    it 'returns passed_course true when average is equal to 6' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [6, 6], type_subject: 'tareas')
      )
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 6
    end

    it 'returns passed_course false when average is less than 6' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [6, 5], type_subject: 'tareas')
      )
      expect(final_score.passed_course).to eq false
    end

    it 'returns score equal 1 when failed 2 tasks' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [10, 10, 1, 1],
                  type_subject: 'tareas')
      )
      expect(final_score.score).to eq 1
    end

    it 'returns passed_course false when average is greater than 6 but failed 2 tasks' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [10, 10, 10, 10, 10, 1, 1],
                  type_subject: 'tareas')
      )
      expect(final_score.passed_course).to eq false
    end

    it 'returns score equal 1 when average is greater than 6 but failed 2 tasks' do
      final_score = scorer.calculate_final_score(
        Score.new(id: 1, inscription_id: 2, scores: [10, 10, 10, 10, 10, 1, 1],
                  type_subject: 'tareas')
      )
      expect(final_score.score).to eq 1
    end
  end
end
