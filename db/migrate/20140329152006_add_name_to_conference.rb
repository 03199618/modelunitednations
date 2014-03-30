class AddNameToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :name, :text
  end
end
