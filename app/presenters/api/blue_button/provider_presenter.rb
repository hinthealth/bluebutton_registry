require 'presenter_base'
class Api::BlueButton::ProviderPresenter < Presenter::Base
  def except_attributes
    ['_id']
  end
  def context
    {
      "@context"=> {
        "@vocab"          => "http://schema.org/",
        "oauth2"          => "http://siframework.org/ABBI/oauth2_endpoints",
        "bb_api"          => "http://siframework.org/ABBI/bbplus_data_endpoints",
        "authorize"       => "http://siframework.org/ABBI/endpoint/authorize",
        "token"           => "http://siframework.org/ABBI/endpoint/token",
        "summary"         => "http://siframework.org/ABBI/endpoint/summary",
        "search"          => "http://siframework.org/ABBI/endpoint/search",
        "client_name"     => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#client_name",
        "client_uri"      => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#client_uri",
        "logo_uri"        => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#logo_uri",
        "tos_uri"         => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#tos_uri",
        "redirect_uris"   => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#redirect_uris",
        "response_type"   => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#response_type",
        "token_endpoint_auth_method" =>
              "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#tokoen_endpoint_auth_method",
        "grant_types"     => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#grant_types",
        "scope"           => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#scope",
        "contacts"        => "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#contacts"
      }
    }
  end
  def as_json(options = {})
    @object.as_json(except: except_attributes).merge(context)
  end
end