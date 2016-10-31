class CreateFavours < ActiveRecord::Migration[5.0]
  def change
    create_table :favours do |t|
      t.integer :contract_id
      t.text :description
      t.boolean :owner_agree, default: true
      t.boolean :payee_agree, default: false

      t.timestamps
    end
  end
end
