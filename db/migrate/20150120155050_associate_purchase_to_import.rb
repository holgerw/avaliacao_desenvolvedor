class AssociatePurchaseToImport < ActiveRecord::Migration
  def change
    add_column :purchases, :import_id, :integer
    add_foreign_key :purchases, :imports
  end
end
