Sequel.migration do
  up do
    add_column :inscriptions, :created_on, Date
    add_column :inscriptions, :updated_on, Date
  end

  down do
    drop_column :inscriptions, :created_on
    drop_column :inscriptions, :updated_on
  end
end
