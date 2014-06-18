class ResolutionSubmitter < ActiveRecord::Base
  belongs_to :resolution
  has_and_belongs_to_many :resolution_submitter_roles, join_table: "resolution_submitter_roles_resolution_submitters"
  belongs_to :delegation_member

  def addResolutionSubmitterRole(resolution_submitter_role_title)
    resolution_submitter_role = ResolutionSubmitterRole.find_by_name(resolution_submitter_role_title)
    if resolution_submitter_role.nil?
      errors[:base] << "Resolution submitter '#{resolution_submitter_role_title}' role not found."
      return
    end
    self.resolution_submitter_roles << resolution_submitter_role
  end
end
