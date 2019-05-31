require_relative '../models/subject'

subject_repository = SubjectRepository.new
unless subject_repository.all.count.positive?
  subject = Subject.new(name: 'Seguridad Nuclear',
                        professor: 'Homero',
                        code: '9999')

  subject_repository.save subject
end
