class AddDelegationIdToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :delegation_id, :integer
  end
end
