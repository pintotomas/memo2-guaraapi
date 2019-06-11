class ParcialesScoresValidator
  def validate(_score)
    raise ParcialesMustHaveExactlyTwoScores
  end
end
