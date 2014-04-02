class Delegate < ActiveRecord::Base
  belongs_to :delegation
  belongs_to :comittee
  has_one :conference, through: :delegation
  belongs_to :participant
  has_one :user, through: :participant

  validates_presence_of :delegation

  def title
    title = "#{position}"
    title = title + " #{delegation.name}" unless delegation.nil?
    title = title + ", #{comittee.name}" unless comittee.nil?
  end

  def username
    name
  end

  def ambassador?
    delegation.ambassador_id == self.id
  end

  def name
    return "#{comittee.name}" unless comittee.nil?
  end

  private

  def position
    if ambassador?
      return "Ambassador"
    else
      return "Delegate"
    end
  end
end
