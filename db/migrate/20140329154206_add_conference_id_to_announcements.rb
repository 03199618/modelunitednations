class AddConferenceIdToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :conference_id, :integer
  end
end
