class CreateResolutionSubmitters < ActiveRecord::Migration
  def change
    create_table :resolution_submitters do |t|

      t.timestamps
    end
  end
end
