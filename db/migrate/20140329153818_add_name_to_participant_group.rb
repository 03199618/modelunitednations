class AddNameToParticipantGroup < ActiveRecord::Migration
  def change
    add_column :participant_groups, :name, :text
  end
end
