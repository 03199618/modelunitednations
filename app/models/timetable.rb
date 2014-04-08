class Timetable < ActiveRecord::Base
  belongs_to :conference
  has_many :events
  validates_presence_of :conference
end
