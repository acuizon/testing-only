class RenameSlugToUrl < ActiveRecord::Migration[5.1]
  def change
    remove_index :short_urls, :slug
    rename_column :short_urls, :slug, :url
    add_index :short_urls, :url, unique: true
  end
end
