class Resolution < ActiveRecord::Base
  has_one :topic
  belongs_to :comittee
  has_and_belongs_to_many :submitters, class_name: "Participant"

  def main_submitter

  end
end
