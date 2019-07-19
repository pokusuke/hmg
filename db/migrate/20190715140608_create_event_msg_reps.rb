class CreateEventMsgReps < ActiveRecord::Migration[5.2]
  def change
    create_table :event_msg_reps do |t|
      t.integer :event_msg_id
      t.integer :rep_user_id
      t.string :msg

      t.timestamps
    end
  end
end
