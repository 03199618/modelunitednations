class CreateComittees < ActiveRecord::Migration
  def change
    create_table :comittees do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
