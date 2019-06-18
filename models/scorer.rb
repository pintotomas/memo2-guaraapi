class Scorer
  def initialize
    @scorers = [TareasScorer.new, ColoquioScorer.new, ParcialesScorer.new]
  end

  def calculate_final_score(score)
    raise ScoreCanNotBeNilError if score.nil?

    final_score = FinalScore.new
    @scorers.each do |scorer|
      scorer_score = scorer.calculate_final_score(score)
      final_score.score += scorer_score.score
      final_score.passed_course = scorer_score.passed_course || final_score.passed_course
    end
    final_score
  end

  def calculate_historical_average(_inscriptions)
    1
  end
end
