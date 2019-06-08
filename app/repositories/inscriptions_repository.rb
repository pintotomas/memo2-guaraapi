class InscriptionsRepository < BaseRepository
  self.table_name = :inscriptions
  self.model_class = 'Inscription'

  protected

  def changeset(inscription)
    {
      student_id: inscription.student_id,
      subject_id: inscription.subject_id,
      code: inscription.code,
      status: inscription.status,
      final_grade: inscription.final_grade
    }
  end
end
