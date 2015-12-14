Rails.application.routes.draw do
  namespace :api do
    resources :sessions, :only => [:create]
    resources :users, :avatars
  end
  post "/api/file_upload",  to: "api/file#upload"
  post "/api/password_resets",  to: "api/password_resets#create"
  post "/api/password_resets/update",  to: "api/password_resets#update"
end
