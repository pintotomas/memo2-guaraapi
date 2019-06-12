class Inscription
  APPROVED_CONST = 'APROBADO'.freeze
  DISAPPROVED_CONST = 'DESAPROBADO'.freeze
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

  def approval_status(passed_course)
    @status = if passed_course
                APPROVED_CONST
              else
                DISAPPROVED_CONST
              end
  end

  def score(score)
    @in_progress = false
    final_score = Scorer.new.calculate_final_score(score)
    approval_status(final_score.passed_course)
    @final_grade = final_score.score
  end
end
