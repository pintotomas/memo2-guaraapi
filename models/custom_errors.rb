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
  def initialize(msg = 'The number of inscriptions has to be less than or equal to the course quota')
    super
  end
end

class UnknownSubjectError < InscriptionError
  def initialize(msg = 'MATERIA_NO_EXISTE')
    super
  end
end
