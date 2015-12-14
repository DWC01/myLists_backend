Rails.application.routes.draw do
  namespace :api do
    resources :sessions, :only => [:create]
    resources :users, :avatars
  end
  post "/api/file_upload",     to: "api/file#upload"
end
