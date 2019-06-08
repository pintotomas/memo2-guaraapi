class Subject
  include ActiveModel::Validations

  attr_accessor :id, :name, :professor, :type, :requires_proyector, :requires_lab,
                :updated_on, :created_on, :quota

  validates :name, :professor, :id, :quota, :type, presence: true
  validates :requires_lab, :requires_proyector, inclusion: [true, false]

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @professor = data[:professor]
    @quota = data[:quota]
    @type = data[:type]
    @requires_lab = data[:requires_lab]
    @requires_proyector = data[:requires_proyector]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
  end
end
