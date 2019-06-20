class InscriptionsRepository < BaseRepository
  self.table_name = :inscriptions
  self.model_class = 'Inscription'

  def find_by_student(student_id)
    inscriptions = load_collection dataset.where(student_id: student_id)
    inscriptions
  end

  def find_by_student_and_subject_id(student_id, subject_id)
    inscription = load_collection dataset.where(student_id: student_id, subject_id: subject_id)
    inscription.first
  end

  def my_inscribed_inscriptions(alias_name)
    inscriptions = dataset.where(student_id: alias_name).join(:subjects, id: :subject_id).select(:subject_id, :name, :professor).all
    inscriptions
  end

  def find_by_student_and_subject_id_and_in_progress(student_id, subject_id)
    inscription = load_collection dataset.where(student_id: student_id, subject_id: subject_id, in_progress: true)
    inscription.first
  end

  def inscribed_subjects_not_approbed(alias_name)
    return SubjectRepository.new.all.all if dataset.where(student_id: alias_name).all.empty?

    inscriptions = DB["SELECT subjects.id, in_progress, name ,professor, status, quota, type, student_id FROM subjects
                      LEFT JOIN ( select * from inscriptions where student_id = '" + alias_name + "') misinscripciones
                      ON misinscripciones.subject_id = subjects.id
                      WHERE
                      (misinscripciones.status is NULL or misinscripciones.status != '" + Inscription::APPROVED_CONST + "')"]

    inscriptions.all
  end

  def inscriptions_in_course(subject_id)
    count = dataset.where(subject_id: subject_id, status: Inscription::INSCRIBED).count
    count
  end

  def approved_inscriptions(subject_id, alias_name)
    count = dataset.where(subject_id: subject_id, student_id: alias_name, status: Inscription::APPROVED_CONST).count
    count
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
