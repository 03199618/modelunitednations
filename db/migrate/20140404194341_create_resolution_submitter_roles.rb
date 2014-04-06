class CreateResolutionSubmitterRoles < ActiveRecord::Migration
  def change
    create_table :resolution_submitter_roles do |t|
      t.text :name

      t.timestamps
    end
  end
end
