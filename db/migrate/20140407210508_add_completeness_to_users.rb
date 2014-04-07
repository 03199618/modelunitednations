class AddCompletenessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :completeness, :float
  end
end
