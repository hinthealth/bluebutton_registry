class Api::BlueButton::ProvidersController < ApiController
  def index
    @providers = Provider.all

    respond_to do |format|
      format.json { render json: @providers.collect{|p| Api::BlueButton::ProviderPresenter.new(p).as_json } }
    end
  end
end