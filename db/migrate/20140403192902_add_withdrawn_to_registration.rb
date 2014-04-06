class AddWithdrawnToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :withdrawn, :boolean
  end
end
