class CreateParticipantGroupMembers < ActiveRecord::Migration
  def change
    create_table :participant_group_members do |t|

      t.timestamps
    end
  end
end
