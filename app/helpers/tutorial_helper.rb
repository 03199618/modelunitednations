module TutorialHelper
  def tutorials(category)
    case category
      when :delegate
        return {
            "How to sign up at a conference" => :sign_up,
            "How to submit a resolution" => :resolution,
            "How to change my settings" => :settings
        }
      when :conference_manager
        return [
            "How to sign up at a conference",
            "How to submit a resolution",
            "How to change my settings"
        ]
      when :group_manager
        return [
            "How to sign up at a conference",
            "How to submit a resolution",
            "How to change my settings"
        ]
      else

    end
  end
end
