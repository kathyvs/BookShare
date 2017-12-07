Rails.application.routes.draw do
  resources :assignment_sets
  devise_for :auth_users do 
  end
  root to: "assignments#index"
  
  resources :events do
    # Assignments are all per event and year

    get "/:year/assignments", to: "assignments#index", as: :assignments
    get "/:year/assignments/:id", to: "assignments#show", as: :user_assignments
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlrails

  
  
  # These are used for the OpenAuth
#  get "/login", to: redirect("/auth/google_oauth2")
#  get "/logout", to: "sessions#destroy"
#  get "/auth/google_oauth2/callback", to: "sessions#create"
end
