Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :projects, only: [:index, :create, :update, :destroy] do
      resources :tickets, only: [:index, :create, :update, :destroy]
    end
  end
end
