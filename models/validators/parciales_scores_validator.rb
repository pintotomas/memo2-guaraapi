class ParcialesScoresValidator
  def validate(score)
    raise ParcialesMustHaveExactlyTwoScores if
    score.scores.length == 1
  end
end
