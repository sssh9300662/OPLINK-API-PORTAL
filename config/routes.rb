SwaggerRails::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure' => 'sessions#failure', :as => :auth_failure
  match '/auth/facebook', :as => :facebook_login

  devise_scope :user do
    get "/logout" => "devise/sessions#destroy", :as => :user_logout
  end

  devise_for :users


  constraints(ForeignDomain::Route) do
    root :to => "docs#show"
    get "/:name", :controller => "resources", :action => 'show'
  end
  
  root :to => 'admin/docs#index'

  namespace :admin do
    root :to => "docs#index"
    resources :docs do
      resources :models
      resources :resources do
        resources :apis
      end
    end
  end
end
