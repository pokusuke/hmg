class AddAvatarPathToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_path, :string
  end
end
