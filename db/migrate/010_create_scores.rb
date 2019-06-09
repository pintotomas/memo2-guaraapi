Sequel.migration do
  up do
    create_table(:scores) do
      primary_key :id
      foreign_key :inscription_id, :inscriptions, null: false
      String :scores, null: false
      String :type_subject, null: false
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:scores)
  end
end
