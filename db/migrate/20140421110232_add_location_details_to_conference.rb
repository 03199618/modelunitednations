class AddLocationDetailsToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :city, :text
    add_column :conferences, :zipcode, :text
    add_column :conferences, :state, :text
    add_column :conferences, :country, :text
  end
end
