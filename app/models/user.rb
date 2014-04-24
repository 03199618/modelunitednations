class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_and_belongs_to_many :roles
  has_many :participants
  has_many :conferences, through: :participants
  has_many :participant_groups, through: :participant_group_members

  has_many :participant_group_members
  has_many :participants
  has_many :delegations, through: :participants
  has_many :delegates, through: :participants
  has_many :resolutions, through: :delegates

  has_attached_file :profile_picture, :styles => { :thumb => "18x18>", :circle => "50x50>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

  before_save :calculate_completeness

  def initial_role=(role_name)
    @initial_role = role_name
    role = Role.find_by_name(role_name)
    self.roles << role
  end

  def has_role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def name
    if firstname || surname
      return "#{firstname} #{surname}"
    else
      return email
    end
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end


  def settings(name)
    return self.send(name)
  end

  def intro
    if read_attribute(:intro)
      write_attribute(:intro, false)
      self.save
      return true
    else
      return false
    end


  end

  def position_papers_due
    return position_papers_due_helper(delegates)
  end

  def completeness
    return read_attribute(:completeness).to_i
  end

  def calculate_completeness
    self.completeness = completeness_helper([:surname, :firstname, :profile_picture])
  end

  def common_conferences(user)
    Conference.find((user.conferences.pluck(:id) & self.conferences.pluck(:id)))
  end

  private

  def completeness_helper(attributes)
    counter = 1.0
    denominator = 1.0

    attributes.each do |a|
      if self.send(a).nil? || self.send(a) == ""
        denominator +=1
      else
        #puts self.send(a)
        counter +=1
        denominator +=1
        #puts counter
        #puts denominator
      end
    end
    #puts "result"
    #puts (counter / denominator)
    return ((counter / denominator) *100).round
  end

  def position_papers_due_helper(delegates)
    counter = 1.0
    denominator = 1.0

    delegates.each do |d|
      if d.position_paper_due
        denominator +=1
      else
        counter +=1
        denominator +=1
      end
    end
    return ((counter / denominator) *100).round
  end

  def create_example_data

  end



end
