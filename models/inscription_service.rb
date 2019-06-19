class InscriptionService
  attr_reader :subject_repository, :inscriptions_repository

  def initialize
    @subject_repository = SubjectRepository.new
    @inscriptions_repository = InscriptionsRepository.new
  end

  def save(inscription)
    subject = @subject_repository.find(inscription.subject_id)
    amount_in_course = @inscriptions_repository.inscriptions_in_course(subject.id)
    @inscriptions_repository.save(inscription) if subject.quota > amount_in_course
  end
end
