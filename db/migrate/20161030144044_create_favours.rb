class CreateFavours < ActiveRecord::Migration[5.0]
  def change
    create_table :favours do |t|
      t.text :favour_type

      t.timestamps
    end
  end
end
