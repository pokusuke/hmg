class AddColumnToEventMsg < ActiveRecord::Migration[5.2]
  def change
    add_column :event_msgs, :photo_url, :string
  end
end
