class CreateParticipantRoles < ActiveRecord::Migration
  def change
    create_table :participant_roles do |t|
      t.text :name

      t.timestamps
    end
  end
end
