class ShortUrl < ApplicationRecord

  has_many :daily_views, dependent: :destroy
  has_many :visitors, through: :daily_views, dependent: :destroy

  validates :original_url, presence: true
  validates :original_url, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

  before_validation :check_protocol, on: :create
  after_create :set_short_url

  def update_stats(req)
    remote_ip = req.remote_ip
    current_time = Time.current
    date_of_visit = current_time.to_date
    hour_of_visit = current_time.hour

    daily_view = self.daily_views.where(view_date: date_of_visit, view_hour: hour_of_visit).first.presence || self.daily_views.create(view_date: date_of_visit, view_hour: hour_of_visit)

    unless daily_view.visitors.where(ip_address: remote_ip).first.present?
      daily_view.visitors.create(ip_address: remote_ip)
    end
  end

  def stats(start_range = nil, end_range = nil)
    if !start_range.present? && !end_range.present?
      start_range = Date.current
      end_range = Date.current
    elsif start_range.present? && !end_range.present?
      end_range = start_range
    elsif !start_range.present? && end_range.present?
      start_range = end_range
    end

    begin
      start_range.to_date
      end_range.to_date
    rescue ArgumentError
      return { errors: "Invalid date/s." }
    end

    daily_view = {}
    daily_view_arr = []

    self.daily_views.where("view_date >= ? AND view_date <= ?", start_range, end_range).each do |view|
      ip_addresses = view.visitors.map(&:ip_address)
      daily_view_arr << view.view_date.to_s

      if daily_view[view.view_date.to_s].present?
        daily_view[view.view_date.to_s] << { hour: view.view_hour, ip_addresses: ip_addresses, ip_count: ip_addresses.count }
      else
        daily_view[view.view_date.to_s] = [{ hour: view.view_hour, ip_addresses: ip_addresses, ip_count: ip_addresses.count }]
      end
    end

    return { daily_views_arr: daily_view_arr.uniq, daily_views: daily_view }
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