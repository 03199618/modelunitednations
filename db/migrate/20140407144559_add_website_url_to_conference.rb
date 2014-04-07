class AddWebsiteUrlToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :website_url, :text
  end
end
