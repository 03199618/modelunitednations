class Participant < ActiveRecord::Base
  has_and_belongs_to_many :participant_roles
  has_and_belongs_to_many :comittees
  belongs_to :delegation
  belongs_to :conference
  belongs_to :user

  def initial_role=(role_name)
    @initial_role = role_name
    role = Role.find_by_name(role_name)
    self.roles << role
  end

  def has_role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

end
