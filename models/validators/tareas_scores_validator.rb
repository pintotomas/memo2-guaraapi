class TareasScoresValidator
  def validate(score)
    raise TareasMustHaveAtLeastOneScoreError unless
    score.scores.length == 1
  end
end
