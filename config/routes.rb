Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :groups, only: [:new, :create, :edit, :update]

  root to: "messages#index"

  resources :users, only: [:edit, :update]
end
