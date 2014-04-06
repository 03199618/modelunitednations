class AddResolutionIdToResolutionSubmitter < ActiveRecord::Migration
  def change
    add_column :resolution_submitters, :resolution_id, :integer
  end
end
