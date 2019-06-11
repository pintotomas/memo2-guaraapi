MINIMUM_SCORES_REQUIRED_LENGTH_CONST = 1

class TareasScoresValidator
  def validate(score)
    raise TareasMustHaveAtLeastOneScoreError unless
    score.scores.length >= MINIMUM_SCORES_REQUIRED_LENGTH_CONST
  end
end
