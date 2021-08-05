class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :total_quantity, null: false
      t.integer :total_price,    null: false
      t.references :user,       null: false, foreign_key: true
      t.references :card,       null: false, foreign_key: true
      t.references :address,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
