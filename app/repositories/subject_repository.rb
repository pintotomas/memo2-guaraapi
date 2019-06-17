class SubjectRepository < BaseRepository
  self.table_name = :subjects
  self.model_class = 'Subject'

  def find_by_name(name)
    subject_by_name = load_collection dataset.where(name: name)
    subject_by_name.first
  end

  def insert_subject(record)
    insert(record)
  end

  protected

  def changeset(subject)
    {
      name: subject.name,
      professor: subject.professor,
      id: subject.id,
      quota: subject.quota,
      type: subject.type,
      requires_proyector: subject.requires_proyector,
      requires_lab: subject.requires_lab
    }
  end
end
