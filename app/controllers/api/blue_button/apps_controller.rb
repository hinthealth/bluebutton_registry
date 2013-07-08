class Api::BlueButton::AppsController < ApiController
  def index
    @apps = App.all

    respond_to do |format|
      format.json { render json: @apps.collect{|a| Api::BlueButton::AppPresenter.new(a).as_json } }
    end
  end
end