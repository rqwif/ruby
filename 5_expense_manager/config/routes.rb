Rails.application.routes.draw do
  root "expenses#index"

  resources :categories

  resources :expenses do
    collection do
      get :paid
      get :this_month
    end
  end
end
