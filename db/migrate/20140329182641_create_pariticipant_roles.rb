class CreatePariticipantRoles < ActiveRecord::Migration
  def change
    create_table :pariticipant_roles do |t|
      t.text :name

      t.timestamps
    end
  end
end
