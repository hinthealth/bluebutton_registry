class Api::BlueButton::RegistriesController < ApiController
  def show
    @registry = Registry.for(request.host_with_port)

    respond_to do |format|
      format.json { render json: Api::BlueButton::RegistryPresenter.new(@registry).as_json }
    end
  end
end