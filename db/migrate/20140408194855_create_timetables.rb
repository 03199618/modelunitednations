class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.integer :conference_id

      t.timestamps
    end
  end
end
