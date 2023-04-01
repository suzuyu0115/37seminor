Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'static_pages#top'
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

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
