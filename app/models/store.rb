class Store < ApplicationRecord
  belongs_to :event_app, :foreign_key => "event_app_id"
end
