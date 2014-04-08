class ChangeRegistrationParticipantGroupIdToParticipantGroupMemberId < ActiveRecord::Migration
  def change
    rename_column :registrations, :participant_group_id, :participant_group_member_id
  end
end
