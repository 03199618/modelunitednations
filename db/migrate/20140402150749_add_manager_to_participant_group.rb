class AddManagerToParticipantGroup < ActiveRecord::Migration
  def change
    add_column :participant_groups, :manager_id, :integer
  end
end
