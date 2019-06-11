class ColoquioScorer
  COLOQUIO_SUBJECT_TYPE_NAME_CONST = 'coloquio'.freeze
  MINIMUM_PASS_VALUE_CONST = 4

  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != COLOQUIO_SUBJECT_TYPE_NAME_CONST

    ColoquioScoresValidator.new.validate(score)
    passed_course = score.scores[0] >= MINIMUM_PASS_VALUE_CONST
    FinalScore.new(passed_course: passed_course, score: score.scores[0])
  end
end
