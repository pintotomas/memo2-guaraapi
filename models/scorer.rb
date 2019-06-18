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

  def calculate_historical_average(inscriptions)
    grades_sum = 0
    quantity_finished_courses = 0
    inscriptions.each do |i|
      if i.status == Inscription::APPROVED_CONST || i.status == Inscription::DISAPPROVED_CONST
        grades_sum += i.final_grade
        quantity_finished_courses += 1
      end
    end
    grades_sum / quantity_finished_courses.to_f
  end
end
