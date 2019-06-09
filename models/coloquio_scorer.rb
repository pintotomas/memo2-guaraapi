class ColoquioScorer
  COLOQUIO_SUBJECT_TYPE_NAME_CONST = 'coloquio'.freeze
  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != COLOQUIO_SUBJECT_TYPE_NAME_CONST
  end
end
