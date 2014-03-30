class Conference < ActiveRecord::Base
  has_many :announcements
  has_many :participants
end
