class CreateConferenceCategories < ActiveRecord::Migration
  def change
    create_table :conference_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
