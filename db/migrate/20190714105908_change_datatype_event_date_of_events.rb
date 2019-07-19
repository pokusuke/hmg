class ChangeDatatypeEventDateOfEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :event_date, :datetime
  end
end
