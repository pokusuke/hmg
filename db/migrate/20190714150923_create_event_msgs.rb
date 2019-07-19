class CreateEventMsgs < ActiveRecord::Migration[5.2]
  def change
    create_table :event_msgs do |t|
      t.integer :event_id
      t.integer :sender_id
      t.string :msg

      t.timestamps
    end
  end
end
