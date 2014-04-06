class ResolutionToDelegate < ActiveRecord::Migration
  def self.up
    create_table :resolutions_delegates, :id => false do |t|
      t.references :delegate, :resolution
    end
  end

  def self.down
    drop_table :resolutions_delegates
  end
end
