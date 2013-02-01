class LogsController < ApplicationController
  
  def index
    @logs = current_user.logs
  end

  def show
    @log = current_user.logs.find(params[:id])
  end

  def new
    @log = current_user.created_logs.new
  end

  def create
    @log = current_user.created_logs.new(params[:log])
    if @log.save
      redirect_to @log, notice: 'Backlog was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @log = current_user.logs.find(params[:id])
    @log.update_attributes(params[:log])
    redirect_to @log
  end
end
