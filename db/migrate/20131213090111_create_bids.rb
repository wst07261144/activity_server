class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|

      t.string :phone
      t.string :price
      t.string :create_time3
      t.string :bid_name
      t.string :create_time2
      t.string :activity_id
      t.string :status
      t.string :name

      t.timestamps
    end
  end
end