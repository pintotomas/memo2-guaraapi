Sequel.migration do
  up do
    create_table(:inscriptions) do
      primary_key :id
      foreign_key :subject_id, :subjects, on_delete: 'cascade'
      String :student_id # es un string porque es el alias de telegram.
      String :status
      Integer :final_grade
    end
  end

  down do
    drop_table(:inscriptions)
  end
end
