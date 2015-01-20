class AddProcessFlagsToImports < ActiveRecord::Migration
  def change
    add_column :imports, :started, :boolean, default: false
    add_column :imports, :completed, :boolean, default: false
  end
end
