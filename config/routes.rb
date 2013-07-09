BlueRegister::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users



  get "home/index"

  namespace :api do
    namespace :blue_button do
      resources :apps, :only => :index
      resource :registry, :only => :show
      resources :providers, :only => :index
      resources :json_web_keys, :only => :index
    end
  end

  resources :apps
  resources :registry
  resources :providers

  match "/generated/public_jwks" => "api/blue_button/json_web_keys#index", :as => "blue_button_public_keys"
  match "/.well-known/bb/registry" => "api/blue_button/registries#show", :as => "blue_button_registry"

  [:app, :provider].each do |resource|
    match "/.well-known/bb/#{resource}" => "api/blue_button/#{resource.to_s.pluralize}#index", :as => "blue_button_#{resource}"
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
