class CreatePrefs < ActiveRecord::Migration[5.2]
  def change
    create_table :prefs do |t|
      t.string :pref_id
      t.string :pref_name
      t.integer :area_id
      t.timestamps
    end
  end
end
