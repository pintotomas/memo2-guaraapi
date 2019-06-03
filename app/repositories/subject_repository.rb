class SubjectRepository < BaseRepository
  self.table_name = :subjects
  self.model_class = 'Subject'

  protected

  def changeset(subject)
    {
      name: subject.name,
      professor: subject.professor,
      code: subject.code,
      quota: subject.quota
    }
  end
end
