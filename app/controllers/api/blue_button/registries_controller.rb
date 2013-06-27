class Api::BlueButton::RegistriesController < ApiController
  def index
    @registries = Registry.all

    respond_to do |format|
      format.json { render json: @registries }
    end
  end
end