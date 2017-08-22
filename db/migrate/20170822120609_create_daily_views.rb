class CreateDailyViews < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_views do |t|
      t.date :view_date
      t.integer :view_hour
      t.references :short_url
      t.timestamps
    end
  end
end
