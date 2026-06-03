Rails.application.routes.draw do
  root "expenses#index"

  resources :categories

  resources :expenses do
    collection do
      get :paid
    end
  end
end
