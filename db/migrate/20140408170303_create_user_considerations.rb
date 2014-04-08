class CreateUserConsiderations < ActiveRecord::Migration
  def change
    create_table :user_considerations do |t|
      t.text :name

      t.timestamps
    end
  end
end
