Rails.application.routes.draw do
  resources :companies, only: [:index, :create] do
    collection do
      post :generate
    end
  end
end
