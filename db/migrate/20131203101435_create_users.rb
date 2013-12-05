class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :forget_key_question
      t.string :forget_key_answer
      t.string :admin

      t.timestamps
    end
  end
end
