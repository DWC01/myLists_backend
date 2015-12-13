Rails.application.routes.draw do
  namespace :api do
    resources :sessions, :only => [:create]
    resources :users, :avatars
  end
end
