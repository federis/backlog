class LogsController < ApplicationController
  before_filter :authenticate_user!  
  before_filter :set_logs, :only => [:show, :show_all, :new]

  def index
    @logs = current_user.logs
  end

  def show
    @log = current_user.logs.find(params[:id])
    @log_items = @log.log_items.incomplete
  end

  def show_all
    @log = current_user.logs.find(params[:id])
    @log_items = @log.log_items
    render :show
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
