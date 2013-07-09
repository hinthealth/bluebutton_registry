class AppsController < ApplicationController
  def new
    @app = App.new
  end

  def create
    @app = App.new(params[:app])
    if @app.save
      flash[:notice] = "Success! Your app is now listed in apps.json"
      redirect_to root_path
    else
      render :new
    end
  end

  protected

    def claim(app)
    {
      iss: root_path,
      sub: app.url,
      iat: app.updated_at,
      kid:
    }
  end

end
