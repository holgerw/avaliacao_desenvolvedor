class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :saved_file
      t.timestamps null: false
    end
  end
end
