class AddUserToParticipantGroupMember < ActiveRecord::Migration
  def change
    add_column :participant_group_members, :user_id, :integer
  end
end
