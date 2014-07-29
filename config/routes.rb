Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :projects, except: [:new]
    resources :tickets, except: [:new]
    resources :comments, except: [:new]
  end

  root to: 'home#index'
end
