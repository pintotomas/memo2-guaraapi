class Score
  include ActiveModel::Validations

  attr_accessor :id, :inscription_id, :scores, :type_subject, :updated_on, :created_on

  def initialize(data = {})
    @id = data[:id]
    @inscription_id = data[:inscription_id]
    @scores = data[:scores]
    @type_subject = data[:type_subject]
  end
end
