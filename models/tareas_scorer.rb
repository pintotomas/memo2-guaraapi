class TareasScorer
  TAREAS_SUBJECT_TYPE_NAME_CONST = 'tareas'.freeze

  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != TAREAS_SUBJECT_TYPE_NAME_CONST
  end
end
