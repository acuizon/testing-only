class ShortUrl < ApplicationRecord

  serialize :stats, Hash

  validates :original_url, presence: true
  validates :original_url, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

  before_validation :check_protocol, on: :create
  after_create :set_short_url

  def update_stats(req)
    remote_ip = req.remote_ip
    date_of_visit = Time.current.strftime("%Y-%m-%d")
    hour_of_visit = Time.current.hour.to_s

    if self.stats[remote_ip].present?
      if self.stats[remote_ip].keys.include?(date_of_visit)
        self.stats[remote_ip][date_of_visit][hour_of_visit].present? ? self.stats[remote_ip][date_of_visit][hour_of_visit] += 1 : self.stats[remote_ip][date_of_visit][hour_of_visit] = 1
      else
        self.stats[remote_ip].merge!({ date_of_visit => { hour_of_visit => 1 } })
      end
    else
      self.stats.merge!({ remote_ip => { date_of_visit => { hour_of_visit => 1 } } })
    end

    self.save
  end

  private

  def check_protocol
    if self.original_url.present? && !self.original_url.strip[/\A(http|https):\/\//i]
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
