class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name, null: false
      t.text   :info,         null: false
      t.integer :price,       null: false
      t.timestamps
    end
  end
end
