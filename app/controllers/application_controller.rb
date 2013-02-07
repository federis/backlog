class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  before_filter :set_logs

private

  def set_logs
    @logs ||= current_user.logs
  end
  
end
