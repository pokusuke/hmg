class Pref < ApplicationRecord
  belongs_to :area, :foreign_key => "area_id"
end
