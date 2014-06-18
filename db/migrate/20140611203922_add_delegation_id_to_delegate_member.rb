class AddDelegationIdToDelegateMember < ActiveRecord::Migration
  def change
    add_column :delegation_members, :delegation_id, :integer
  end
end
