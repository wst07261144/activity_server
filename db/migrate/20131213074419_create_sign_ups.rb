class CreateSignUps < ActiveRecord::Migration
  def change
    create_table :sign_ups do |t|

      t.string :name
      t.string :phone
      t.string :create_time1
      t.string :activity_id

      t.timestamps
    end
  end
end
