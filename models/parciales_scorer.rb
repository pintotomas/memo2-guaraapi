class ParcialesScorer
  PARCIALES_SUBJECT_TYPE_NAME_CONST = 'parciales'.freeze
  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != PARCIALES_SUBJECT_TYPE_NAME_CONST
  end
end
