class AddPositionPaperToDelegate < ActiveRecord::Migration
  def change
    add_column :delegates, :position_paper, :text
  end
end
