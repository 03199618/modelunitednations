class AddDelegateIdToResolutionSubmitter < ActiveRecord::Migration
  def change
    add_column :resolution_submitters, :delegate_id, :integer
  end
end
