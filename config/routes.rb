Rails.application.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :institutions, only: [:show, :create, :update, :destroy]
    resources :users, only: [:index, :show, :create, :update, :destroy]
  end
end
