class ShortUrl < ApplicationRecord

  validates :original_url, presence: true
  validates :original_url, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

  before_validation :check_protocol, on: :create
  after_create :set_short_url

  private

  def check_protocol
    if !self.original_url[/\A(http|https):\/\//i]
      self.original_url = "http://#{self.original_url}"
    end
  end

  def set_short_url
    length = 4
    leeway = 500000

    while(self.id > ((58 ** length) - leeway)) do
      length += 1
    end

    loop do
      possible_url = SecureRandom.base58(length)
      break self.url = possible_url unless ShortUrl.find_by(url: possible_url).present?
    end

    self.save
  end

end
