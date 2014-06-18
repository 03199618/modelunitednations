class Delegation < Group
  belongs_to :conference
  has_many :delegation_members

  validates_presence_of :name, :conference_id

  def ambassador=(delegate)
    self.ambassador_id = delegate.id
  end
end
