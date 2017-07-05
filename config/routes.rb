Rails.application.routes.draw do
  resources :books
  root to: "books#index"
  resources :events do
    get "/:year/assignments", to: "assignments#index", as: :assignments
  end
  resources :profiles
  resources :sessions, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlrails

  # Assignments are all per event and year (and sometimes profile id)
  
  
  # These are used for the OpenAuth
  get "/login", to: redirect("/auth/google_oauth2")
  get "/logout", to: "sessions#destroy"
  get "/auth/google_oauth2/callback", to: "sessions#create"
end
