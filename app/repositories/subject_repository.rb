class SubjectRepository < BaseRepository
  self.table_name = :subjects
  self.model_class = 'Subject'

  def find_by_name(name)
    subject_by_name = load_collection dataset.where(name: name)
    subject_by_name.first
  end

  protected

  def changeset(subject)
    {
      name: subject.name,
      professor: subject.professor,
      code: subject.code,
      quota: subject.quota,
      type: subject.type
    }
  end
end
