class DelegationMemberToDelegationMemberRole < ActiveRecord::Migration
  def change
    def self.up
      create_table :delegation_members_delegation_member_roles, :id => false do |t|
        t.references :delegation_member_role, :delegation_member
      end
    end

    def self.down
      drop_table :delegation_members_delegation_member_roles
    end
  end
end
