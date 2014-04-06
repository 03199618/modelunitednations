class AddParticipantGroupIdToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :participant_group_id, :integer
  end
end
