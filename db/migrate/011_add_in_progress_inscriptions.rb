Sequel.migration do
  up do
    add_column :inscriptions, :in_progress, TrueClass, default: true
  end

  down do
    drop_column :inscriptions, :in_progress
  end
end
