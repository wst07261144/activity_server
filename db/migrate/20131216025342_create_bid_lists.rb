class CreateBidLists < ActiveRecord::Migration
  def change
    create_table :bid_lists do |t|
      t.string :activity_id
      t.string :name
      t.string :user

      t.timestamps
    end
  end
end
