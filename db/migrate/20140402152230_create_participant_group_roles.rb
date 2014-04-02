class CreateParticipantGroupRoles < ActiveRecord::Migration
  def change
    create_table :participant_group_roles do |t|
      t.text :name

      t.timestamps
    end
  end
end
