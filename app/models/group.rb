class Group < ActiveRecord::Base
  self.abstract_class = true

  def is_user(user, role)
    #self.send(class.name.downcase+"_member").joins((class.name+"_member_roles").to_sym).where((class.name+"_member_roles").to_sym {name: role.to_s}).map(&:user_id).include? user.id
  end

  def all_user
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