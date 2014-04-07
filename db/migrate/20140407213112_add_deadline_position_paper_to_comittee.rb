class AddDeadlinePositionPaperToComittee < ActiveRecord::Migration
  def change
    add_column :comittees, :deadline_position_paper, :datetime
  end
end
