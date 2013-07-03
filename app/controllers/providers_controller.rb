class ProvidersController < ApplicationController
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(params[:provider])
    if @provider.create
      flash[:message] = "Success! Please allow 24 hours for us to approve"
      redirect_to root_path
    else
      render :new
    end
  end

end
