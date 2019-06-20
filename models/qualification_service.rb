class QualificationService
  def initialize(request_body)
    @inscription = InscriptionsRepository.new.find_by_student_and_subject_id(
      request_body['username_alumno'], request_body['codigo_materia']
    )
    validate_inscription
    @subject_type = SubjectRepository.new.find(request_body['codigo_materia']).type
    @grades = JSON.parse(request_body['notas'])
  rescue JSON::ParserError
    raise InvalidScoreInfo
  end

  def score
    score = Score.new(inscription_id: @inscription.id, scores: @grades,
                      type_subject: @subject_type)

    validate_score(score)
    @inscription.score(score)

    InscriptionsRepository.new.save(@inscription)
    ScoresRepository.new.save(score)
  rescue Sequel::ForeignKeyConstraintViolation
    raise ForeignKeyConstraintViolation
  end

  private

  def validate_inscription
    raise InvalidStudentError if @inscription.nil? || !@inscription.in_progress
  end

  def validate_score(score)
    raise InvalidScoreInfo unless score.valid?
  end
end
