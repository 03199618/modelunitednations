class CreateDelegationMembers < ActiveRecord::Migration
  def change
    create_table :delegation_members do |t|
      t.integer :participant_id

      t.timestamps
    end
  end
end
