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
