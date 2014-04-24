class AddLogoToConference < ActiveRecord::Migration
  def self.up
    add_attachment :conferences, :logo
  end

  def self.down
    remove_attachment :conferences, :logo
  end
end
