class CreateDelegations < ActiveRecord::Migration
  def change
    create_table :delegations do |t|
      t.integer :conference_id
      t.text :name
      t.integer :ambassador_id

      t.timestamps
    end
  end
end
