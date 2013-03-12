class CollaborationsController < ApplicationController
  before_filter :set_logs, only: :index
  def index
    @log = current_log
    @collaborations = current_log.collaborations
  end

  def create
    @collaboration = current_log.collaborations.new(params[:collaboration])
    flash_msg = @collaboration.save ? {notice: "User added"} : {error: "There were problems adding the user:<br>#{@collaboration.errors.full_messages.join("<br>")}".html_safe}
    redirect_to log_collaborations_url(current_log)
  end

  def destroy
    @collaboration = current_log.collaborations.find(params[:id])
    @collaboration.destroy
    redirect_to log_collaborations_url(current_log)
  end
end
