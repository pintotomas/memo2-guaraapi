Sequel.migration do
  up do
    add_column :subjects, :quota, Integer
  end

  down do
    drop_column :subjects, :quota
  end
end
