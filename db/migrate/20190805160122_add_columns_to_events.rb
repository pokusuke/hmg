class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_published_flg, :boolean
    add_column :events, :event_recruiting_flg, :boolean
    add_column :events, :pref_id, :integer
    add_column :events, :city, :string
    add_column :events, :place_detail, :string
    add_column :events, :event_detail, :text
    add_column :events, :event_recruit_start_date, :date
    add_column :events, :event_recruit_end_date, :date
    add_column :events, :event_recruit_number, :integer
    add_column :events, :event_entrance_fee, :integer
    add_column :events, :photo_url1, :string
    add_column :events, :photo_url2, :string 
    add_column :events, :photo_url3, :string
    add_column :events, :photo_url4, :string
  end
end
