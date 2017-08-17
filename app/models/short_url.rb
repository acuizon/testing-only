class ShortUrl < ApplicationRecord

  validates :original_url, :slug, presence: true
  validates :slug, uniqueness: true
  validates :original_url, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

  before_validation :process, on: :create

  private

  def process
    if !self.original_url[/\A(http|https):\/\//i]
      self.original_url = "http://#{self.original_url}"
    end

    loop do
      possible_slug = SecureRandom.urlsafe_base64(10)
      break self.slug = possible_slug unless ShortUrl.find_by(slug: possible_slug).present?
    end
  end

end
