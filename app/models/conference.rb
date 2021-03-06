class Conference < Group
  include PublicActivity::Model
  tracked except: [:create, :destroy]

  has_many :announcements, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :delegations, dependent: :destroy
  has_many :committees, dependent: :destroy
  has_many :participant_groups
  has_many :registrations, dependent: :destroy
  has_many :group_registrations, dependent: :destroy
  has_many :timetables, dependent: :destroy

  has_attached_file :logo, :styles => { :thumb => "18x18>", :circle => "50x50>" }, :default_url => "/images/conferences/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.street.present? and obj.street_changed? }

  def timetable
    result = timetables.first
    if result.nil?
      new_timetable = self.timetables.new
      new_timetable.save
      result = new_timetable
    end
    return result
  end

  def managers
    self.participants.joins(:participant_roles).where(participant_roles: {name: "manager"} )
  end

  def delegates
    self.participants.joins(:participant_roles).where(participant_roles: {name: "delegate"} )
  end

  def manager?(user)
    return self.participants.joins(:participant_roles).where(participant_roles: {name: "manager"} ).map(&:user_id).include? user.id
  end

  def delegate?(user)
    return self.participants.joins(:participant_roles).where(participant_roles: {name: "delegate"} ).map(&:user_id).include? user.id
  end

  def participant?(user)
    return self.participants.map(&:user_id).include? user.id
  end

  def addRegistration(user, participant_group_member = nil, group_registration = nil)
    registration = Registration.new(user: user, conference_id: self.id)
    registration.participant_group_member = participant_group_member unless participant_group_member.nil?
    registration.group_registration = group_registration unless participant_group_member.nil?
    registration.save
  end

  def addManager(user)
    participant = Participant.new(user_id: user.id)
    participant.addParticipantRole("manager")

    self.participants << participant
  end

  def addDelegate(user)
    participant = Participant.new(user_id: user.id)
    participant.addParticipantRole("delegate")

    self.participants << participant
  end

  def addParticipantGroup(participant_group)
    participant_group.participant_group_members.each do |participant_group_member|
      addParticipantGroupMember(participant_group_member)
    end
  end

  def addParticipantGroupMember(participant_group_member)
    participant = Participant.new(participant_group_member_id: participant_group_member.id, user_id: participant_group_member.user.id,)
    self.participants << participant
  end

  def addParticipant(user)
    participant = Participant.new(user: user)
    self.participants << participant
  end


  def participantForUser(user)
    participant = Participant.where(user_id: user.id).first
  end

  def placards
    pdf = Prawn::Document.new
    delegates.each do |delegate|
      #pdf.move 100,100
      pdf.text "#{delegate.delegation.name}", rotate: 90 unless delegate.delegation.nil?
      #pdf.move 200,200
      pdf.text "#{delegate.delegation.name}", rotate: -90 unless delegate.delegation.nil?
      #pdf.start_new_page
    end
    return pdf
  end

  def acronym
    if read_attribute(:acronym).nil?
      return name
    else
      return read_attribute(:acronym)
    end
  end

  def name
    if read_attribute(:acronym).nil?
      return name_helper
    else
      return read_attribute(:name)
    end
  end

  def public?
    return public
  end

  def goIntoSession
    in_session = true
  end

  def full_address
    "#{[street, city, zipcode, state, country].compact.join(', ')}"
  end

  def missing_required_attributes
    required_attributes = [:starts_at, :ends_at, :acronym, :size, :name, :description, :city]
    missing_attributes = []
    required_attributes.each do |attribute|
      if self.send(attribute).nil?
        missing_attributes << attribute
      end
    end

    if !logo?
      missing_attributes << :logo
    end
    return missing_attributes
  end

  def publishable?
    if missing_required_attributes.any?
      return false
    else
      return true
    end
  end

  private

  def name_helper
    if read_attribute(:name).nil?
      return read_attribute(:name) #"#{self.managers.first.name}'s Conference"
    else
      return read_attribute(:name)
    end
  end


end
