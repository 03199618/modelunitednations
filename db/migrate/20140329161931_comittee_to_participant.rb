class ComitteeToParticipant < ActiveRecord::Migration
  def self.up
    create_table :comittees_participants, :id => false do |t|
      t.references :committee, :participant
    end
  end

  def self.down
    drop_table :comittees_participants
  end
end
