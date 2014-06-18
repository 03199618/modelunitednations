class DropDelegates < ActiveRecord::Migration
  def change
    drop_table :delegates
  end
end
