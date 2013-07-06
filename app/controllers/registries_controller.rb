class RegistriesController < ApplicationController

  def new
    @registry = Registry.new
  end

  def create
    @registry = Registry.new(params[:registry])
    if @registry.save
      flash[:message] = "Success! Please allow 24 hours for us to approve"
      redirect_to root_path
    else
      render :new
    end

  end

end
