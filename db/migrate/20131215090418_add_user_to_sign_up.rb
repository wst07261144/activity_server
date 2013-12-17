class AddUserToSignUp < ActiveRecord::Migration
  def change
    add_column :sign_ups, :user, :string
  end
end
