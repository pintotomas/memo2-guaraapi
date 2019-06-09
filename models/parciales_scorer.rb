class ParcialesScorer
  PARCIALES_SUBJECT_TYPE_NAME_CONST = 'parciales'.freeze
  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != PARCIALES_SUBJECT_TYPE_NAME_CONST

    sum = 0
    score.scores.each { |s| sum += s }
    final_score = sum / score.scores.length
    FinalScore.new(score: final_score, passed_course: final_score >= 6)
  end
end
