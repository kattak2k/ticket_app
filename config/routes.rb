Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :projects, except: [:show, :new], shallow: true do
      resources :tickets, except: [:show, :new], shallow: true do
        resources :comments, except: [:index, :show, :new]
      end
    end
  end
end
