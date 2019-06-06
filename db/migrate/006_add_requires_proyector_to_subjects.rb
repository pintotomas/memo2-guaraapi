Sequel.migration do
  up do
    add_column :subjects, :requires_proyector, TrueClass, default: false
  end

  down do
    drop_column :subjects, :requires_proyector
  end
end
