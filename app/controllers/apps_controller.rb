class AppsController < ApplicationController
  def new
    @app = App.new
  end

  def create
    @app = App.new(params[:app])
    if @app.create
      flash[:message] = "Success! Please allow 24 hours for us to approve"
      redirect_to root_path
    else
      render :new
    end
  end
end
