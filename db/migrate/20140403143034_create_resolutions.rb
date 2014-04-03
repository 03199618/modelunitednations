class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :content
      t.integer :comittee_id

      t.timestamps
    end
  end
end
