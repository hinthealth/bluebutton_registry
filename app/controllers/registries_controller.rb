class RegistriesController < ApplicationController

  def new
    @registry = Registry.new
  end

  def create
    @registry = Registry.new(params[:registry])
    if @registry.save
      flash[:notice] = "Success! Your registry is now available in the registry.json"
      redirect_to root_path
    else
      render :new
    end

  end

end
