SwaggerRails::Application.routes.draw do

  devise_scope :user do
    get "/logout" => "devise/sessions#destroy", :as => :user_logout
  end

  devise_for :users

 # constraints(ForeignDomain::Route) do
 #   root :to => "docs#show"
 #   get "/:name", :controller => "resources", :action => 'show'
 # end
  scope :controller => "docs", :path => "/docs", :as => "docs" do
    get '/:name' => :show, :as => "doc"
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
