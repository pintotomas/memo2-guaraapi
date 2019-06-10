class TareasScorer
  TAREAS_SUBJECT_TYPE_NAME_CONST = 'tareas'.freeze
  MINIMUM_SCORES_REQUIRED_LENGTH_CONST = 1
  MINIMUM_PASS_VALUE_CONST = 6

  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != TAREAS_SUBJECT_TYPE_NAME_CONST
    raise TareasMustHaveAtLeastOneScoreError unless
    score.scores.length >= MINIMUM_SCORES_REQUIRED_LENGTH_CONST

    score_sum = 0
    score.scores.each { |s| score_sum += s }
    final_score = score_sum / score.scores.length
    FinalScore.new(score: final_score, passed_course: final_score >= MINIMUM_PASS_VALUE_CONST)
  end
end
