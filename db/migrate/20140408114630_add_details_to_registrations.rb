class AddDetailsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :group_registration_id, :integer
  end
end
