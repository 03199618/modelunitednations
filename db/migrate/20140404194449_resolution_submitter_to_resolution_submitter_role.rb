class ResolutionSubmitterToResolutionSubmitterRole < ActiveRecord::Migration
  def self.up
    create_table :resolution_submitter_roles_resolution_submitters, :id => false do |t|
      t.references :resolution_submitter, :resolution_submitter_role
    end
  end

  def self.down
    drop_table :resolution_submitter_roles_resolution_submitters
  end
end
