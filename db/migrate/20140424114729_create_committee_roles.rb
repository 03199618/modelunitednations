class CreateCommitteeRoles < ActiveRecord::Migration
  def change
    create_table :committee_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
