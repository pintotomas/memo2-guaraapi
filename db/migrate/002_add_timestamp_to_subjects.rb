Sequel.migration do
  up do
    add_column :subjects, :created_on, Date
    add_column :subjects, :updated_on, Date
  end

  down do
    drop_column :subjects, :created_on
    drop_column :subjects, :updated_on
  end
end
