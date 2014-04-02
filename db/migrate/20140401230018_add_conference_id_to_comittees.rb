class AddConferenceIdToComittees < ActiveRecord::Migration
  def change
    add_column :comittees, :conference_id, :integer
  end
end
