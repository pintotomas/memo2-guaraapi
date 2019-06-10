class Inscription
  include ActiveModel::Validations

  INSCRIBED = 'Inscripto'.freeze

  attr_accessor :id, :student_id, :subject_id, :status, :final_grade,
                :updated_on, :created_on, :quota, :in_progress

  def initialize(data = {})
    @id = data[:id]
    @student_id = data[:student_id]
    @subject_id = data[:subject_id]
    @status = data[:status]
    @final_grade = data[:final_grade]
    @in_progress = data[:in_progress].nil? || data[:in_progress]
  end
end
