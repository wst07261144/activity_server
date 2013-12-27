class ModifyAttributes < ActiveRecord::Migration
  def change
    rename_column :users, :forget_key_question, :question
    rename_column :users, :forget_key_answer, :answer
  end
end
