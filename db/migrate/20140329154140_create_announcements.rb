class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
