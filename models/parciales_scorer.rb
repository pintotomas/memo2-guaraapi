class ParcialesScorer
  PARCIALES_SUBJECT_TYPE_NAME_CONST = 'parciales'.freeze
  PASS_MIN_VALUE_CONST = 6
  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != PARCIALES_SUBJECT_TYPE_NAME_CONST

    ParcialesScoresValidator.new.validate(score)
    sum = 0
    score.scores.each { |s| sum += s }
    final_score = sum / score.scores.length
    FinalScore.new(score: final_score, passed_course: final_score >= PASS_MIN_VALUE_CONST)
  end
end
