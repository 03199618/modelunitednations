class AddParticipantGroupIdToParticipantGroupMember < ActiveRecord::Migration
  def change
    add_column :participant_group_members, :participant_group_id, :integer
  end
end
