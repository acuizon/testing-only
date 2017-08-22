class CreateVisitors < ActiveRecord::Migration[5.1]
  def change
    create_table :visitors do |t|
      t.string :ip_address
      t.references :daily_view
      t.timestamps
    end
  end
end
