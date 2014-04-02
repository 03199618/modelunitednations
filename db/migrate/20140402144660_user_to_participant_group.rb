class UserToParticipantGroup < ActiveRecord::Migration
  def self.up
    create_table :participant_groups_users, :id => false do |t|
      t.references :user, :participant_group
    end
  end

  def self.down
    drop_table :participant_groups_users
  end
end
