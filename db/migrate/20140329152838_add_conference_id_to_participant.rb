class AddConferenceIdToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :conference_id, :integer
  end
end
