class ParticipantParticipantRole < ActiveRecord::Migration
  def self.up
    create_table :participants_participant_roles, :id => false do |t|
      t.references :participant, :participant_role
    end
  end

  def self.down
    drop_table :participants_participant_roles
  end
end
