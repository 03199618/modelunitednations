class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :content
      t.references :announced_at, polymorphic: true
      t.references :announcer, polymorphic: true
      t.timestamps
    end
  end
end
