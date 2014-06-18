class CreateCreateDelegationMemberRoles < ActiveRecord::Migration
  def change
    create_table :delegation_member_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
