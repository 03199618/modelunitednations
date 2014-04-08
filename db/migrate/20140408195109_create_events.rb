class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :timetable_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :name

      t.timestamps
    end
  end
end
