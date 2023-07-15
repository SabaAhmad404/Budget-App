Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  unauthenticated do
  root "splash#index", as: :unauthenticated_user
  end

  authenticated :user do
    root "categories#index" , as: :authenticated_user

  end

  resources :categories, only: [ :index,:new, :show, :create, :update, :destroy] do
    resources :entities, only:[:index, :new, :create, :update, :destroy]
  end
     
end
