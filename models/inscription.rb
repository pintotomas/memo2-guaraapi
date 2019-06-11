class Inscription
  APPROVED_CONST = 'APROBADO'.freeze
  DISAPPROVED_CONST = 'DESAPROBADO'.freeze
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

  def approval_status(passed_course)
    @status = if passed_course
                APPROVED_CONST
              else
                DISAPPROVED_CONST
              end
  end
end
