class AddParticipantGroupMemberIdToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :participant_group_member_id, :integer
  end
end
