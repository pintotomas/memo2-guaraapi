class TareasScoresValidator
  def validate(score)
    raise TareasMustHaveAtLeastOneScoreError if
    score.scores.empty?
  end
end
