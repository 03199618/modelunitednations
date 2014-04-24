class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.integer :comittee_id
      t.integer :participant_id
      t.integer :committee_role_id

      t.timestamps
    end
  end
end
