class ParticipantToParticipantGroup < ActiveRecord::Migration
  def self.up
    create_table :participants_participant_groups, :id => false do |t|
      t.references :participant, :participant_group
    end
  end

  def self.down
    drop_table :participants_participant_groups
  end
end
