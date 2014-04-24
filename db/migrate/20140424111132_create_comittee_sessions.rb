class CreateComitteeSessions < ActiveRecord::Migration
  def change
    create_table :comittee_sessions do |t|
      t.integer :comittee_id
      t.datetime :ended_at

      t.timestamps
    end
  end
end
