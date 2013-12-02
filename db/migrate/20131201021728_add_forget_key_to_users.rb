class AddForgetKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forget_key_question, :string
    add_column :users, :forget_key_answer, :string
  end
end
