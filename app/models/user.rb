class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles
  has_many :participants
  has_many :conferences, through: :participants
  #has_many :participant_groups, through: :participant_group_members
  has_many :delegations, through: :participants
  has_many :participant_group_members

  def initial_role=(role_name)
    @initial_role = role_name
    role = Role.find_by_name(role_name)
    self.roles << role
  end

  def has_role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def pariticipant_groups
    nil
  end
end
