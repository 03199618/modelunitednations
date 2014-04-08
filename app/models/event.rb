class Event < ActiveRecord::Base
  belongs_to :timetable
  validates_presence_of :timetable, :name, :starts_at, :ends_at, :description
end
