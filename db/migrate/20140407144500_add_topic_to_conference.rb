class AddTopicToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :topic, :text
  end
end
