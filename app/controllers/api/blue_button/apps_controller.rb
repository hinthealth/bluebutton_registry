class Api::BlueButton::AppsController < ApiController
  def index
    @apps = App.all

    respond_to do |format|
      format.json { render json: @apps }
    end
  end
end