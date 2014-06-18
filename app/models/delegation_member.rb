class DelegationMember < ActiveRecord::Base
  belongs_to :participant
  belongs_to :committee
  belongs_to :delegation
  has_one :resolution_submitter
  has_and_belongs_to_many :delegation_member_roles


  validates_presence_of :delegation

  def title
    title = "#{position}"
    title = title + " #{delegation.name}" unless delegation.nil?
    title = title + ", #{committee.name}" unless committee.nil?
  end

  def name
    if !committee.nil?
      name = committee.name
      name = name + user.name unless user.nil?
      return name
    elsif !user.nil?
      return user.name
    else
      return "Delegate of #{delegation.name}"
    end

  end

  def position_paper_due
    return ((position_paper.nil? || position_paper == "") && committee.deadline_position_paper.to_i > DateTime.now.to_i) unless committee.nil?
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
