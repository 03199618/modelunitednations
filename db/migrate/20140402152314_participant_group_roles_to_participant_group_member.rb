class ParticipantGroupRolesToParticipantGroupMember < ActiveRecord::Migration

  def self.up
    create_table :participant_group_roles_participant_group_member, :id => false do |t|
      t.references :participant_group_member, :participant_group_role
    end
  end

  def self.down
    drop_table :participant_group_roles_participant_group_member
  end


end
