class InscriptionsRepository < BaseRepository
  self.table_name = :inscriptions
  self.model_class = 'Inscription'

  def find_by_student_and_subject_id(student_id, subject_id)
    inscription = load_collection dataset.where(student_id: student_id, subject_id: subject_id)
    inscription.first
  end

  protected

  def changeset(inscription)
    {
      student_id: inscription.student_id,
      code: inscription.subject_id,
      status: inscription.status,
      final_grade: inscription.final_grade
    }
  end
end
