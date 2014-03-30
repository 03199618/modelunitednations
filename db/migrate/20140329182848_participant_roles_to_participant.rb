class ParticipantRolesToParticipant < ActiveRecord::Migration
  def self.up
    create_table :participants_roles_participants, :id => false do |t|
      t.references :participants_role, :participant
    end
  end

  def self.down
    drop_table :participants_roles_participants
  end
end
