class CommitteeMemberToCommitteeRole < ActiveRecord::Migration
  def self.up
    create_table :committee_members_committee_roles, :id => false do |t|
      t.references :committee_role, :committee_member
    end
  end

  def self.down
    drop_table :resolutions_delegates
  end
end
