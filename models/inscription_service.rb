class InscriptionService
  attr_reader :subject_repository, :inscriptions_repository

  def initialize
    @subject_repository = SubjectRepository.new
    @inscriptions_repository = InscriptionsRepository.new
  end
end
