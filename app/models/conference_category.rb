class ConferenceCategory < ActiveRecord::Base
  validates_presence_of :name

  def name
    I18n.t("conference.category.#{read_attribute (:name)}")
  end
end
