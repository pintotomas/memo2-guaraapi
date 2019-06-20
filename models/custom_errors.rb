class ColoquioScoreHasToBePresentAndUniqueError < RuntimeError
end

class ParcialesMustHaveExactlyTwoScores < RuntimeError
end

class TareasMustHaveAtLeastOneScoreError < RuntimeError
end

class ScoreCanNotBeNilError < RuntimeError
end

class InscriptionError < RuntimeError
end

class QualificationError < RuntimeError
  def initialize(msg)
    super
  end
end

class ExceededQuotaError < InscriptionError
  def initialize(msg = 'CUPO_COMPLETO')
    super
  end
end

class UnknownSubjectError < InscriptionError
  def initialize(msg = 'MATERIA_NO_EXISTE')
    super
  end
end

class InvalidInscriptionError < InscriptionError
  def initialize(msg = 'INSCRIPCION_INVALIDA')
    super
  end
end

class InvalidScoreInfo < QualificationError
  def initialize(msg = 'NOTA_INVALIDA')
    super
  end
end

class ForeignKeyConstraintViolation < QualificationError
  def initialize(msg = 'Foreign key constraint violation')
    super
  end
end

class ApprovedSubjectError < InscriptionError
  def initialize(msg = Inscription::APPROVED_SUBJECT)
    super
  end
end

class DuplicateInscriptionError < InscriptionError
  def initialize(msg = Inscription::DUPLICATE_INSCRIPTION)
    super
  end
end

class InvalidStudentError < QualificationError
  def initialize(msg = 'ALUMNO_INCORRECTO')
    super
  end
end
