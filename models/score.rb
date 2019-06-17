class Score
  include ActiveModel::Validations
  INVALID_SCORE_CONST = 'NOTA_INVALIDA'.freeze

  attr_accessor :id, :inscription_id, :scores, :type_subject, :updated_on, :created_on
  validate :score_numbers
  def initialize(data = {})
    @id = data[:id]
    @inscription_id = data[:inscription_id]
    @scores = data[:scores]
    @type_subject = data[:type_subject]
  end

  private

  def score_numbers
    errors.add(:scores, INVALID_SCORE_CONST) if scores.nil?
  end
end
