class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|

      t.timestamps
    end
  end
end
