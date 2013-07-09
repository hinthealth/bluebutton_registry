class Api::BlueButton::JsonWebKeysController < ApiController
  def index
    @keys = JsonWebKey.all
    respond_with @keys.as_json(:only => ['kid', 'kty', 'alg', 'n', 'e'])
  end
end