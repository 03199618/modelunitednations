class CommitteeMember < ActiveRecord::Base
  belongs_to :committee
  belongs_to :participant
  has_and_belongs_to_many :committee_roles, join_table: "committee_members_committee_roles"

  def addRole(role_title)
    role = CommitteeRole.find_by_name(role_title)
    if role.nil?
      errors[:base] << "Committee role '#{role_title}' not found."
      return
    end
    self.committee_roles << role
  end
end
