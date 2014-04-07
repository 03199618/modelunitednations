class AddOrganizerToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :organizer, :text
  end
end
