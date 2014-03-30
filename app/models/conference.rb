class Conference < ActiveRecord::Base
  has_many :announcements
end
