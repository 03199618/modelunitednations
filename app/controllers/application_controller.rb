class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    if user_signed_in?
      I18n.locale = current_user.locale.to_sym
    else

    #logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    #logger.debug "* Locale set to '#{I18n.locale}'"
    end
  end

  def set_timezone
    tz = current_user ? current_user.timezone : nil
    Time.zone = tz || ActiveSupport::TimeZone["London"]
  end



  #CanCan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def extract_locale_from_accept_language_header
    begin
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    rescue
      I18n.default_locale
    end
  end
end
