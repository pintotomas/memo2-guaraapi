class InscriptionsRepository < BaseRepository
  self.table_name = :inscriptions
  self.model_class = 'Inscription'

  def find_by_student_and_subject_id(student_id, subject_id)
    inscription = load_collection dataset.where(student_id: student_id, subject_id: subject_id)
    inscription.first
  end

  def my_inscribed_inscriptions(alias_name)
    inscriptions = dataset.where(student_id: alias_name,
                                 in_progress: true).join(:subjects, id: :subject_id).select(:subject_id, :name, :professor).all
    inscriptions
  end

  def inscribed_subjects_not_approbed(alias_name)
    return SubjectRepository.new.all.all if dataset.where(student_id: alias_name).all.empty?

    inscriptions = DB["SELECT subject_id, name ,professor, status
        FROM subjects
        RIGHT JOIN ( select * from inscriptions where student_id = '" + alias_name + "') misinscripciones
        ON misinscripciones.subject_id = subjects.id
        WHERE misinscripciones.status != '" + Inscription::APPROVED_CONST + "'"]

    inscriptions.all
  end

  protected

  def changeset(inscription)
    {
      student_id: inscription.student_id,
      subject_id: inscription.subject_id,
      status: inscription.status,
      final_grade: inscription.final_grade,
      in_progress: inscription.in_progress

    }
  end
end
