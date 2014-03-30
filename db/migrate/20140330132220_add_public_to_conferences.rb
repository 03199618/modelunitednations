class AddPublicToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :public, :boolean, default: true
  end
end
