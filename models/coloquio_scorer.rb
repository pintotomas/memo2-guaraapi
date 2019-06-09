class ColoquioScorer
  COLOQUIO_SUBJECT_TYPE_NAME_CONST = 'coloquio'.freeze
  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != COLOQUIO_SUBJECT_TYPE_NAME_CONST
    raise ColoquioScoreHasToBePresentAndUniqueError unless score.scores.length == 1

    passed_course = score.scores[0] >= 4
    FinalScore.new(passed_course: passed_course, score: score.scores[0])
  end
end
