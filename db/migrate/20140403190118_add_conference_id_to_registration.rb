class AddConferenceIdToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :conference_id, :integer
  end
end
