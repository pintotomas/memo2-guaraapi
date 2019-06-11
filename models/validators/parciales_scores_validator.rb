REQUIRED_SCORES_LENGTH_CONST = 2

class ParcialesScoresValidator
  def validate(score)
    raise ParcialesMustHaveExactlyTwoScores unless
    score.scores.length == REQUIRED_SCORES_LENGTH_CONST
  end
end
