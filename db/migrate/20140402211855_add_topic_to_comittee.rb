class AddTopicToComittee < ActiveRecord::Migration
  def change
    add_column :comittees, :topic, :text
  end
end
