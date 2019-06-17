class Subject
  include ActiveModel::Validations

  INVALID_SUBJECT_ID = 'CODIGO_ERRONEO'.freeze
  MANDATORY_NAME = 'NOMBRE_ERRONEO'.freeze
  MAX_SUBJECTS = 9999
  MAX_QUOTA_CONST = 300
  INVALID_TYPE_CONST = 'MODALIDAD_INVALIDA'.freeze
  EXCEEDED_QUOTA_CONST = 'CUPO_EXCEDIDO'.freeze
  MAX_QUOTA_CONST = 300
  attr_accessor :id, :name, :professor, :type, :requires_proyector, :requires_lab,
                :updated_on, :created_on, :quota

  validates :professor, :quota, :type, presence: true
  validates :requires_lab, :requires_proyector, inclusion: [true, false]
  validates :name, presence: { message: MANDATORY_NAME }

  validates :id, numericality: { only_integer: true, less_than_or_equal_to:
      MAX_SUBJECTS, message: INVALID_SUBJECT_ID }

  validates :id, presence: { message: INVALID_SUBJECT_ID }

  validates :type, inclusion: { in: %w[coloquio tareas parciales], message: INVALID_TYPE_CONST }

  validates :quota, numericality: { less_than_or_equal_to: MAX_QUOTA_CONST, message: EXCEEDED_QUOTA_CONST }

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
