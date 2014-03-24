class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_time_zone

  def access_denied(exception)
    render text: 'Not Authorized', status: 403
  end

  private

  def set_time_zone
    if(cookies[:timezone])
      Time.zone = ActiveSupport::TimeZone[-(cookies[:timezone].to_i / 60)]
    else
      Time.zone = ActiveSupport::TimeZone["America/Chicago"]
    end

    Chronic.time_class = Time.zone
  end
end

