class CreateDelegates < ActiveRecord::Migration
  def change
    create_table :delegates do |t|
      t.integer :participant_id
      t.integer :delegation_id
      t.integer :comittee_id

      t.timestamps
    end
  end
end
