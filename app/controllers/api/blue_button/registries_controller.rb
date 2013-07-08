class Api::BlueButton::RegistriesController < ApiController
  def index
    @registries = Registry.all

    respond_to do |format|
      format.json { render json: @registries.collect{|r| Api::BlueButton::RegistryPresenter.new(r).as_json } }
    end
  end
end