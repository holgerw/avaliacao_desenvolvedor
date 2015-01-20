class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :comprador
      t.string :descricao
      # SQLite3 max precision = 16
      t.decimal :preco_uniario, :precision => 16, :scale => 2
      t.integer :quantidade
      t.string :endereco
      t.string :fornecedor

      t.timestamps null: false
    end
  end
end
