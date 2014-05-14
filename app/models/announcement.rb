class Announcement < ActiveRecord::Base
  belongs_to :announced_at

  validates_presence_of :title, :content
end
