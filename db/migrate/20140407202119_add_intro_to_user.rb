class AddIntroToUser < ActiveRecord::Migration
  def change
    add_column :users, :intro, :boolean, default: true
  end
end
