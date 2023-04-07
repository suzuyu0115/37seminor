Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'static_pages#top'
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  get 'oauths/secret_word', to: 'oauths#secret_word'
  post 'oauths/secret_word', to: 'oauths#secret_word'
  get 'login', to: 'oauths#login', :as => :login
  delete 'logout' => 'oauths#destroy', :as => :logout

  resources :users
  resources :quests, only: %i[index new create show edit update] do
    collection do
      get 'joins'
    end
    member do
      patch 'toggle_state'
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update]
  resources :joins, only: %i[create destroy]
end
