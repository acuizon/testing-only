class Visitor < ApplicationRecord

  belongs_to :daily_view

  validates :daily_view_id, :ip_address, presence: true

end
