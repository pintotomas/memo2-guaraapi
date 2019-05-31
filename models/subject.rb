class Subject
  include ActiveModel::Validations

  attr_accessor :id, :name, :professor, :code, :updated_on, :created_on

  validates :name, :professor, :code, presence: true

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @professor = data[:professor]
    @code = data[:code]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end
end
