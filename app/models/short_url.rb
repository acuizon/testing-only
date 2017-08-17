class ShortUrl < ApplicationRecord

  validates :original_url, :slug, presence: true
  validates :slug, uniqueness: true

end
