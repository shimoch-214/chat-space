Rails.application.routes.draw do
  devise_scope :user do
    get 'users' => 'users/registrations#index', as: :user_registration
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: "groups#index"
  
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end

end
