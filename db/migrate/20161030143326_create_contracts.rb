class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.integer :item_id
      t.integer :user_id #payee
      t.string  :payee_name #used when payee is not a registered user
      t.string  :payee_contact #used when payee is not a registered user
      t.decimal :contract_price, precision: 13, scale: 2
      t.integer :payment_type_id
      t.integer :favour_id, default: nil
      t.boolean :clear, default: false

      t.timestamps
    end
  end
end
