class AddStreetToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :street, :text
  end
end
