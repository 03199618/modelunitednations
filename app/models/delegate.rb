class Delegate < ActiveRecord::Base
  belongs_to :delegation
  belongs_to :comittee
  has_one :conference, through: :delegation
  belongs_to :participant
  has_one :user, through: :participant
  has_many :resolution_submitters
  has_many :resolutions, through: :resolution_submitters

  validates_presence_of :delegation

  def title
    title = "#{position}"
    title = title + " #{delegation.name}" unless delegation.nil?
    title = title + ", #{comittee.name}" unless comittee.nil?
  end

  def username
    return name
  end

  def ambassador?
    delegation.ambassador_id == self.id
  end

  def name
    if !comittee.nil?
      name = comittee.name
      name = name + user.name unless user.nil?
      return name
    elsif !user.nil?
      return user.name
    else
      return "Delegate of #{delegation.name}"
    end

  end

  def position_paper_due
    return ((position_paper.nil? || position_paper == "") && comittee.deadline_position_paper.to_i > DateTime.now.to_i) unless comittee.nil?
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
