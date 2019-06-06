Sequel.migration do
  up do
    add_column :subjects, :requires_lab, TrueClass, default: false
  end

  down do
    drop_column :subjects, :requires_lab
  end
end
