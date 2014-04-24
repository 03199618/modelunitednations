class AddDatesToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :starts_at, :datetime
    add_column :conferences, :ends_at, :datetime
  end
end
