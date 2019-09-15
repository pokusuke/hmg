class AddColumnToEventMsgRep < ActiveRecord::Migration[5.2]
  def change
    add_column :event_msg_reps, :photo_url, :string
  end
end
