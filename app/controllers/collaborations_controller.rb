class CollaborationsController < ApplicationController
  def index
    @collaborations = current_log.collaborations
  end

  def create
    @collaboration = current_log.collaborations.new(params[:collaboration])
    flash_msg = @collaboration.save ? {notice: "User added"} : {error: "There were problems adding the user:<br>#{@collaboration.errors.full_messages.join("<br>")}".html_safe}
    redirect_to @collaboration.log, flash: flash_msg
  end
end
