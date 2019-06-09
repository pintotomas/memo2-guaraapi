class ParcialesScorer
  PARCIALES_SUBJECT_TYPE_NAME_CONST = 'parciales'.freeze
  MINIMUM_SCORES_LENGTH_CONST = 1
  PASS_MIN_VALUE_CONST = 6
  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != PARCIALES_SUBJECT_TYPE_NAME_CONST
    raise ParcialesMustHaveAtLeastOneScore unless score.scores.length >= MINIMUM_SCORES_LENGTH_CONST

    sum = 0
    score.scores.each { |s| sum += s }
    final_score = sum / score.scores.length
    FinalScore.new(score: final_score, passed_course: final_score >= PASS_MIN_VALUE_CONST)
  end
end
