Mym::Application.routes.draw do
  resources :categories
  resources :receipts do
    collection do
      post :scan
    end
  end

  root :to => "home#index"
  devise_for :users
  resources :users
end