class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :bill_id
      t.string :item_name
      t.decimal :item_price, precision: 13, scale: 2
      t.integer :contract_id

      t.timestamps
    end
  end
end
