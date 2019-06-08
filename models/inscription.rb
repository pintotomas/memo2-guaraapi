class Inscription
  include ActiveModel::Validations
  attr_accessor :id, :student_id, :subject_id, :status, :final_grade,
                :updated_on, :created_on, :quota
  def initialize(data = {})
    @id = data[:id]
    @student_id = data[:student_id]
    @subject_id = data[:subject_id]
    @status = data[:status]
    @final_grade = data[:final_grade]
  end
end
