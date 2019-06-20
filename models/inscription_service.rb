class InscriptionService
  attr_reader :subject_repository, :inscriptions_repository

  def initialize
    @subject_repository = SubjectRepository.new
    @inscriptions_repository = InscriptionsRepository.new
  end

  def save(inscription)
    begin
      subject = @subject_repository.find(inscription.subject_id)
    rescue Sequel::NoMatchingRow
      raise UnknownSubjectError
    end
    amount_in_course = @inscriptions_repository.inscriptions_in_course(subject.id)
    raise ExceededQuotaError unless subject.quota > amount_in_course

    @inscriptions_repository.save(inscription)
  end
end
