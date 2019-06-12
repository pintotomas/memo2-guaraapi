Sequel.migration do
  up do
    drop_column :inscriptions, :final_grade
    add_column :inscriptions, :final_grade, Float
  end

  down do
    drop_column :inscriptions, :final_grade
  end
end
