Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :index]
  resources :events, only: [:new, :create, :index] do
    member do
      put "like", to: "events#like"
    end
  end
  resources :services, only: [:show, :index]
  resources :posts, only: [:index, :show, :new, :create] do
    member do
      put "like", to: "posts#like"
    end
    resources :comments, only: :create
    end
  resources :inboxes, only: [:index, :new, :create, :show] do
    resources :messages, only: [:index, :new, :create, :show]
    resources :participants, only: [:new, :create]
  end
  get "newdirectmessage", to: "inboxes#new_direct_message", as: :new_direct_message
  post "createdirectmessage", to: "inboxes#create_direct_message", as: :create_direct_message

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "profile", to: "profiles#me", as: :profile
  get "profile/edit", to: "profiles#edit", as: :edit_profile
  patch "profile", to: "profiles#update", as: :update_profile
  get "choice", to: "pages#choice"
  get "component", to: "pages#component"
end
