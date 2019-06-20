class QualificationService
  def score(inscription, subject_type, grades)
    raise InvalidStudentError if inscription.nil? || !inscription.in_progress

    score = Score.new(inscription_id: inscription.id, scores: grades,
                      type_subject: subject_type)

    raise InvalidScoreInfo unless score.valid?

    inscription.score(score)
    InscriptionsRepository.new.save(inscription)
    ScoresRepository.new.save(score)
  end
end
