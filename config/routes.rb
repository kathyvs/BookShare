Rails.application.routes.draw do
  devise_for :auth_users
  root to: "assignment_sets#index"

  resources :books

  resources :events do
    # Assignment sets are all per event and year

    get "/:year/assignments", to: "assignment_sets#index", as: :assignments
    get "/:year/assignments/:id", to: "assignment_sets#show", as: :user_assignments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlrails



  # These are used for the OpenAuth
#  get "/login", to: redirect("/auth/google_oauth2")
#  get "/logout", to: "sessions#destroy"
#  get "/auth/google_oauth2/callback", to: "sessions#create"
end
