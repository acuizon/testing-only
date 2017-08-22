class DropStatsFromShortUrl < ActiveRecord::Migration[5.1]
  def change
    remove_column :short_urls, :stats, :text
  end
end
