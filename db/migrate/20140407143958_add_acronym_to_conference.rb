class AddAcronymToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :acronym, :text
  end
end
