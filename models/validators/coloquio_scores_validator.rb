SCORES_REQUIRED_LENGTH_CONST = 1

class ColoquioScoresValidator
  def validate(score)
    raise ColoquioScoreHasToBePresentAndUniqueError unless
       score.scores.length == SCORES_REQUIRED_LENGTH_CONST
  end
end
