Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'static_pages#top'
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users
  resources :quests, only: %i[index new create show]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update]
end
