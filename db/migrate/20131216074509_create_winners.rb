class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.string :activity_id
      t.string :bid_name
      t.string :user
      t.string :name
      t.string :phone
      t.string :price

      t.timestamps
    end
  end
end
