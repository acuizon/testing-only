class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.string :slug
      t.text :original_url
      t.datetime :created_at
    end

    add_index :short_urls, :slug, unique: true
  end
end
