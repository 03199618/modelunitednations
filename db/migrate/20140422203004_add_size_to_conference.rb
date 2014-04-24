class AddSizeToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :size, :integer
  end
end
