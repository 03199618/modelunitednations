class UserToParticipantGroupMember < ActiveRecord::Migration

  def self.up
    create_table :participant_group_members_users, :id => false do |t|
      t.references :user, :participant_group_member
    end
  end

  def self.down
    drop_table :participant_group_members_users
  end


end
