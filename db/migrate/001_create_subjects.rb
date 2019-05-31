Sequel.migration do
  up do
    create_table(:subjects) do
      primary_key :id
      String :name, null: false
      String :professor, null: false
      Integer :code, null: false
    end
  end

  down do
    drop_table(:subjects)
  end
end
