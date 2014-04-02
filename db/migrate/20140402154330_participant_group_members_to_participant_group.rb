class ParticipantGroupMembersToParticipantGroup < ActiveRecord::Migration
  def self.up
    create_table :participant_groups_participant_group_members, :id => false do |t|
      t.references :participant_group_member, :participant_group
    end
  end

  def self.down
    drop_table :participant_groups_participant_group_members
  end
end
