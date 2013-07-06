class ProvidersController < ApplicationController
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(params[:provider])
    if @provider.save
      flash[:notice] = "Success! Your provider is now listed in providers.json"
      redirect_to root_path
    else
      render :new
    end
  end

end
