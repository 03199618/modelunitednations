class ComitteeToTopic < ActiveRecord::Migration
  def self.up
    create_table :comittees_topics, :id => false do |t|
      t.references :topic, :committee
    end
  end

  def self.down
    drop_table :comittees_topics
  end
end
