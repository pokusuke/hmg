class RemovePasswordDigestFromUser < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :password_digest, :string
  end
  def down
    add_column :users, :password_digest, :string
  end
end
