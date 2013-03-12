class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :authenticate_user!

private

	def set_logs
		@logs ||= current_user.logs
	end

  def current_log
    @current_log ||= current_user.logs.find(params[:log_id])
  end

end




