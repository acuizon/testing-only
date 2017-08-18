class AddStatsToShortUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :short_urls, :stats, :text
  end
end
