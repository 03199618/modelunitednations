class Delegation < ActiveRecord::Base
  belongs_to :conference
  has_many :delegates

  validates_presence_of :name, :conference_id

  def ambassador=(delegate)
    self.ambassador_id = delegate.id
  end
end
