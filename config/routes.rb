Rails.application.routes.draw do
  root to: "events#index"
  resources :events
  resources :profiles
  resources :sessions, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlrails

  # These are used for the OpenAuth
  get "/login", to: redirect("/auth/google_oauth2")
  get "/logout", to: "sessions#destroy"
  get "/auth/google_oauth2/callback", to: "sessions#create"
end
