class AddRejectedToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :rejected, :boolean
  end
end
