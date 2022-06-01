DeviseApi::Engine.routes.draw do
  # TODO delete devise_for to prevent conflicts with base applications
  devise_for :users, class_name: "DeviseApi::User"

  namespace :api do
    namespace :v1 do
      resources :users, only: :update
      namespace :users do
        post '/sign_up', to: 'registrations#create'
      end
    end
  end
end
