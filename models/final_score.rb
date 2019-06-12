class FinalScore
  include ActiveModel::Validations
  DEFAULT_SCORE_CONST = 0
  DEFAULT_COURSE_APPROVAL_CONST = false
  attr_accessor :score, :passed_course

  def initialize(data = {})
    @score = data[:score] || DEFAULT_SCORE_CONST
    @passed_course = data[:passed_course] || DEFAULT_COURSE_APPROVAL_CONST
  end
end
