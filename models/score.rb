class Score
  include ActiveModel::Validations
  INVALID_SCORE_CONST = 'NOTA_INVALIDA'.freeze
  MAX_SCORE_VALUE = 10
  MIN_SCORE_VALUE = 0

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
    errors.add(:scores, INVALID_SCORE_CONST) if scores.nil? || !scores.is_a?(Array) || scores.empty? || !valid_values(scores)
  end

  def valid_values(scores)
    all_valid = true
    scores.each do |score|
      all_valid = false unless (score.is_a? Numeric) && (score <= MAX_SCORE_VALUE) && (score >= MIN_SCORE_VALUE)
    end
    all_valid
  end
end
