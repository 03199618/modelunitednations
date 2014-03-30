class CreateParticipantGroups < ActiveRecord::Migration
  def change
    create_table :participant_groups do |t|
      t.integer :conference_id

      t.timestamps
    end
  end
end
