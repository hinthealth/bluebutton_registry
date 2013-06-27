class Api::BlueButton::ProvidersController < ApiController
  def index
    @providers = Provider.all

    respond_to do |format|
      format.json { render json: @providers }
    end
  end
end