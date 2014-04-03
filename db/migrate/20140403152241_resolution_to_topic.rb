class ResolutionToTopic < ActiveRecord::Migration
  def self.up
    create_table :resolutions_topics, :id => false do |t|
      t.references :topic, :resolution
    end
  end

  def self.down
    drop_table :resolutions_topics
  end
end
