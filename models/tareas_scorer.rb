class TareasScorer
  TAREAS_SUBJECT_TYPE_NAME_CONST = 'tareas'.freeze
  MINIMUM_SCORES_REQUIRED_LENGTH_CONST = 1

  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != TAREAS_SUBJECT_TYPE_NAME_CONST
    raise TareasMustHaveAtLeastOneScoreError unless
    score.scores.length >= MINIMUM_SCORES_REQUIRED_LENGTH_CONST
  end
end
