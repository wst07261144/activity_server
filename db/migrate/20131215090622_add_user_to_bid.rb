class AddUserToBid < ActiveRecord::Migration
  def change
    add_column :bids, :user, :string
  end
end
