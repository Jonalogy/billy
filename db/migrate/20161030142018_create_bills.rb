class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.decimal :total_price, precision: 13, scale: 2
      t.date :due
      t.boolean :clear, default: false

      t.timestamps
    end
  end
end
