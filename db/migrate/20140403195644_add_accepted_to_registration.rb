class AddAcceptedToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :accepted, :boolean
  end
end
