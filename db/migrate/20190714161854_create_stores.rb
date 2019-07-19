class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.integer :event_id
      t.integer :event_app_id
      t.integer :store_owner_id
      t.string :store_desc

      t.timestamps
    end
  end
end
