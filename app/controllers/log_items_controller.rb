class LogItemsController < ApplicationController
  respond_to :json

  def create
    @log_item = current_log.log_items.new(params[:log_item])
    @log_item.creator = current_user
    flash_msg = @log_item.save ? {notice: "Item created"} : {error: "There were problems creating your item:<br>#{@log_item.errors.full_messages.join("<br>")}".html_safe}
    redirect_to @log_item.log, flash: flash_msg
  end

  def update
    @log_item = current_log.log_items.find(params[:id])
    @log_item.update_attributes(params[:log_item])
    redirect_to @log_item.log
  end

  def position
    @log_item = current_log.log_items.find(params[:id])
    @log_item.update_position(params[:position])
    head :ok
  end

private
  
  def current_log
    @current_log ||= current_user.logs.find(params[:log_id])
  end

end
