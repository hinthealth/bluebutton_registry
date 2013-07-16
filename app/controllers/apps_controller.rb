class AppsController < ApplicationController
  def new
    @app = App.new
  end

  def create
    @app = App.new(params[:app])
    if @app.save && @app.generate_token!(root_url)
      # AppMailer.registered(@app).deliver # TODO: Enable outbound email.
      flash[:notice] = "Success! Your app is now listed in apps.json"
      redirect_to app_path(@app.id)
    else
      render :new
    end
  end

  def show
    @app = App.find(params[:id])
  end

end
