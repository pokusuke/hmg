class AddColumnToMsg < ActiveRecord::Migration[5.2]
  def change
    add_column :msgs, :photo_url, :string
  end
end
