class DailyView < ApplicationRecord

  belongs_to :short_url
  has_many :visitors

  validates :short_url_id, :view_date, :view_hour, presence: true

end
