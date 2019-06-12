describe Scorer do
  subject(:scorer) { described_class.new }

  describe 'model' do
    it { is_expected.to respond_to(:calculate_final_score) }
  end

  describe 'calculate_final_score' do
    let(:tareas_score) do
      Score.new(id: 1, inscription_id: 2, scores: [8, 8, 8],
                type_subject: 'tareas')
    end
    let(:parciales_score) do
      Score.new(id: 1, inscription_id: 2, scores: [7, 7],
                type_subject: 'parciales')
    end
    let(:coloquio_score) do
      Score.new(id: 1, inscription_id: 2, scores: [4],
                type_subject: 'coloquio')
    end

    it 'raises ScoreCanNotBeNilError when score is nil' do
      scorer = described_class.new
      expect { scorer.calculate_final_score(nil) }.to raise_error(ScoreCanNotBeNilError)
    end

    it 'calculates score with parciales logic when it is the score type' do
      final_score = scorer.calculate_final_score(parciales_score)
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 7
    end

    it 'calculates score with tareas logic when it is the score type' do
      final_score = scorer.calculate_final_score(tareas_score)
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 8
    end

    it 'calculates score with coloquio logic when it is the score type' do
      final_score = scorer.calculate_final_score(coloquio_score)
      expect(final_score.passed_course).to eq true
      expect(final_score.score).to eq 4
    end
  end
end
