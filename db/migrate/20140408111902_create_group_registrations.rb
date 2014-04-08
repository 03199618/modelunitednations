class CreateGroupRegistrations < ActiveRecord::Migration
  def change
    create_table :group_registrations do |t|
      t.integer :conference_id
      t.integer :participant_group_id
      t.boolean :withdrawn
      t.boolean :accepted
      t.boolean :rejected

      t.timestamps
    end
  end
end
