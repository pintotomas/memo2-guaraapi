class Subject
  include ActiveModel::Validations

  attr_accessor :id, :name, :professor, :code, :updated_on, :created_on, :quota

  validates :name, :professor, :code, :quota, presence: true

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @professor = data[:professor]
    @code = data[:code]
    @quota = data[:quota]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end
end
